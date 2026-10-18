"""
src/evaluator.py
----------------
Evaluación del modelo y cálculo del error por variable.
Incluye la interfaz hacia el sistema experto futuro.
"""

import numpy as np
import pandas as pd
import torch
import mlflow
from sklearn.metrics import f1_score, confusion_matrix
import matplotlib.pyplot as plt
import seaborn as sns

from src.data_loader import SENSOR_COLS


# ---------------------------------------------------------------------------
# Cálculo de scores de anomalía
# ---------------------------------------------------------------------------

def compute_reconstruction_errors(model, windows: np.ndarray, batch_size: int = 256):
    """
    Calcula el error de reconstrucción para cada ventana y cada variable.

    Devuelve
    --------
    errors_global   : array (n_windows,) — MSE global por ventana
    errors_per_var  : array (n_windows, n_features) — MSE por variable y ventana
    """
    device = next(model.parameters()).device
    model.eval()

    errors_global = []
    errors_per_var = []

    with torch.no_grad():
        for i in range(0, len(windows), batch_size):
            batch = torch.tensor(
                windows[i : i + batch_size], dtype=torch.float32
            ).to(device)
            x_hat = model(batch)

            # Error global por ventana: MSE sobre todas las variables y tiempo
            err_global = ((batch - x_hat) ** 2).mean(dim=(1, 2))
            errors_global.append(err_global.cpu().numpy())

            # Error por variable: MSE sobre el eje temporal
            err_var = ((batch - x_hat) ** 2).mean(dim=1)
            errors_per_var.append(err_var.cpu().numpy())

    return np.concatenate(errors_global), np.concatenate(errors_per_var, axis=0)


def compute_threshold(train_errors: np.ndarray, percentile: float = 95.0) -> float:
    """
    Umbral de anomalía basado en el percentil del error en datos normales.

    El percentil 95 significa: "el 5% de los casos más extremos en datos
    normales ya se consideran anomalía". Se puede ajustar según la tolerancia
    a falsas alarmas del sistema experto.
    """
    threshold = np.percentile(train_errors, percentile)
    print(f"📏 Umbral (p{percentile:.0f}): {threshold:.5f}")
    return threshold


# ---------------------------------------------------------------------------
# Interfaz hacia el sistema experto
# ---------------------------------------------------------------------------

def build_expert_interface(
    errors_per_var: np.ndarray,
    threshold_per_var: np.ndarray,
    sensor_cols: list = SENSOR_COLS,
) -> pd.DataFrame:
    """
    Construye el DataFrame que alimentará al sistema experto futuro.

    Cada fila = una ventana temporal.
    Cada columna = score de anomalía por variable (valor continuo)
    + flag binario si supera el umbral individual.

    Ejemplo de uso por el sistema experto:
    ---------------------------------------
    IF score_Current > umbral_Current AND score_Voltage < umbral_Voltage:
        → "Sobrecarga mecánica sin fallo eléctrico"

    IF score_Temperature > umbral_Temperature AND score_RateRMS > umbral_RateRMS:
        → "Pérdida de eficiencia en circuito térmico"

    Parámetros
    ----------
    errors_per_var    : array (n_windows, n_features)
    threshold_per_var : array (n_features,) — umbral por variable
    sensor_cols       : lista de nombres de variables

    Devuelve
    --------
    pd.DataFrame con columnas:
        score_{variable}   → valor continuo del error
        flag_{variable}    → bool: ¿supera el umbral?
        n_vars_anomalous   → cuántas variables están en anomalía
        anomaly_score      → score global normalizado (0-1)
    """
    df = pd.DataFrame()

    for i, col in enumerate(sensor_cols):
        df[f"score_{col}"] = errors_per_var[:, i]
        df[f"flag_{col}"] = errors_per_var[:, i] > threshold_per_var[i]

    df["n_vars_anomalous"] = df[[f"flag_{c}" for c in sensor_cols]].sum(axis=1)

    # Score global normalizado: qué fracción de variables están en anomalía
    df["anomaly_score"] = df["n_vars_anomalous"] / len(sensor_cols)

    return df


# ---------------------------------------------------------------------------
# Métricas de evaluación
# ---------------------------------------------------------------------------

def evaluate(
    model,
    test_data: dict,
    train_errors: np.ndarray = None,
    threshold_percentile: float = 95.0,
    sensor_cols: list = SENSOR_COLS,
    log_to_mlflow: bool = True,
):
    """
    Evaluación completa del modelo sobre el conjunto de test.

    Parámetros
    ----------
    model               : modelo entrenado
    test_data           : dict devuelto por prepare_dataloaders
    train_errors        : errores globales en train (para calcular umbral)
    threshold_percentile: percentil para el umbral de anomalía
    sensor_cols         : nombres de las variables de sensor
    log_to_mlflow       : si True, registra métricas en el run activo de MLflow

    Devuelve
    --------
    results : dict con métricas, predicciones e interfaz para sistema experto
    """
    windows = test_data["windows"]
    labels = test_data["labels"]

    # Errores de reconstrucción
    errors_global, errors_per_var = compute_reconstruction_errors(model, windows)

    # Umbral (usando errores de train si están disponibles, si no del test normal)
    if train_errors is not None:
        threshold = compute_threshold(train_errors, threshold_percentile)
    else:
        normal_mask = labels == 0
        threshold = compute_threshold(errors_global[normal_mask], threshold_percentile)

    # Umbral por variable (para la interfaz del sistema experto)
    if train_errors is not None:
        # Recalculamos errores por variable solo en datos normales de train
        # si se pasan; aquí usamos el percentil sobre test normal como aproximación
        normal_mask = labels == 0
        threshold_per_var = np.percentile(
            errors_per_var[normal_mask], threshold_percentile, axis=0
        )
    else:
        normal_mask = labels == 0
        threshold_per_var = np.percentile(
            errors_per_var[normal_mask], threshold_percentile, axis=0
        )

    # Predicciones binarias
    predictions = (errors_global > threshold).astype(int)

    # Métricas
    f1 = f1_score(labels, predictions, zero_division=0)
    cm = confusion_matrix(labels, predictions)
    tn, fp, fn, tp = cm.ravel()
    far = fp / (fp + tn) if (fp + tn) > 0 else 0  # False Alarm Rate
    mar = fn / (fn + tp) if (fn + tp) > 0 else 0  # Missing Alarm Rate

    print(f"\n📊 Resultados:")
    print(f"   F1 Score  : {f1:.4f}  (referencia SKAB Conv-AE: 0.78)")
    print(f"   FAR       : {far*100:.2f}% (falsas alarmas)")
    print(f"   MAR       : {mar*100:.2f}% (anomalías no detectadas)")

    # Interfaz para sistema experto
    expert_df = build_expert_interface(errors_per_var, threshold_per_var, sensor_cols)

    results = {
        "f1": f1,
        "far": far,
        "mar": mar,
        "threshold": threshold,
        "threshold_per_var": dict(zip(sensor_cols, threshold_per_var)),
        "errors_global": errors_global,
        "errors_per_var": errors_per_var,
        "predictions": predictions,
        "labels": labels,
        "expert_interface": expert_df,
    }

    if log_to_mlflow:
        try:
            mlflow.log_metrics({
                "test_f1": f1,
                "test_far": far,
                "test_mar": mar,
                "threshold": threshold,
            })
        except Exception:
            pass  # Si no hay run activo, ignoramos

    return results


# ---------------------------------------------------------------------------
# Visualizaciones
# ---------------------------------------------------------------------------

def plot_reconstruction_errors(results: dict, sensor_cols: list = SENSOR_COLS):
    """
    Gráfico del error de reconstrucción global a lo largo del tiempo,
    marcando las anomalías reales y las predicciones.
    """
    fig, axes = plt.subplots(2, 1, figsize=(14, 7), sharex=True)

    t = range(len(results["errors_global"]))

    # Panel superior: error global con umbral
    axes[0].plot(t, results["errors_global"], label="Error reconstrucción", alpha=0.7)
    axes[0].axhline(
        results["threshold"], color="red", linestyle="--", label=f"Umbral ({results['threshold']:.4f})"
    )
    axes[0].fill_between(
        t,
        0,
        results["errors_global"],
        where=results["labels"] == 1,
        alpha=0.3,
        color="orange",
        label="Anomalía real",
    )
    axes[0].set_ylabel("MSE global")
    axes[0].legend()
    axes[0].set_title("Error de reconstrucción global")

    # Panel inferior: error por variable (heatmap)
    errors_df = pd.DataFrame(
        results["errors_per_var"], columns=sensor_cols
    )
    # Normalizar por variable para comparabilidad visual
    errors_norm = (errors_df - errors_df.min()) / (errors_df.max() - errors_df.min() + 1e-8)

    axes[1].imshow(
        errors_norm.T,
        aspect="auto",
        cmap="YlOrRd",
        interpolation="nearest",
    )
    axes[1].set_yticks(range(len(sensor_cols)))
    axes[1].set_yticklabels(sensor_cols, fontsize=8)
    axes[1].set_xlabel("Ventana temporal")
    axes[1].set_title("Error por variable (normalizado) — interfaz sistema experto")

    plt.tight_layout()
    return fig


def plot_expert_interface_sample(results: dict, n_samples: int = 200):
    """
    Muestra un extracto del DataFrame de interfaz con el sistema experto,
    resaltando las ventanas anómalas.
    """
    expert_df = results["expert_interface"].copy()
    expert_df["label"] = results["labels"]

    # Tomar muestra que incluya anomalías
    anomaly_idx = np.where(results["labels"] == 1)[0]
    if len(anomaly_idx) > 0:
        start = max(0, anomaly_idx[0] - 20)
        sample = expert_df.iloc[start : start + n_samples]
    else:
        sample = expert_df.head(n_samples)

    score_cols = [c for c in sample.columns if c.startswith("score_")]

    fig, ax = plt.subplots(figsize=(14, 5))
    data = sample[score_cols].T
    sns.heatmap(
        data,
        ax=ax,
        cmap="YlOrRd",
        cbar_kws={"label": "Score anomalía por variable"},
        xticklabels=50,
    )
    ax.set_title("Interfaz sistema experto: scores por variable")
    ax.set_yticklabels(
        [c.replace("score_", "") for c in score_cols], rotation=0, fontsize=9
    )

    plt.tight_layout()
    return fig
