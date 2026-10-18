"""
src/data_loader.py
------------------
Carga y preprocesa los datasets de SKAB.
Separa datos normales (para train) de datos con anomalías (para test).
"""

import os
import glob
import numpy as np
import pandas as pd
from sklearn.preprocessing import MinMaxScaler
from torch.utils.data import Dataset, DataLoader
import torch


# Variables del sensor — en el mismo orden que en los CSV de SKAB
SENSOR_COLS = [
    "Accelerometer1RMS",
    "Accelerometer2RMS",
    "Current",
    "Pressure",
    "Temperature",
    "Thermocouple",
    "Voltage",
    "RateRMS",
]

COLUMN_ALIASES = {
    "Volume Flow RateRMS": "RateRMS",
}


def load_skab_files(data_dir: str) -> pd.DataFrame:
    """
    Carga todos los CSV de la carpeta data/ de SKAB y los concatena.
    Cada fichero = un experimento con una sola anomalía.

    Parámetros
    ----------
    data_dir : str
        Ruta a la carpeta data/ del repositorio SKAB.
        Ejemplo: "../data"

    Devuelve
    --------
    pd.DataFrame con columnas de sensores + anomaly + changepoint + source_file
    """
    pattern = os.path.join(data_dir, "**", "*.csv")
    files = glob.glob(pattern, recursive=True)

    if not files:
        raise FileNotFoundError(
            f"No se encontraron CSV en {data_dir}. "
            "Asegúrate de haber descargado la carpeta data/ de SKAB."
        )

    dfs = []
    for f in sorted(files):
        df = pd.read_csv(f, sep=";", index_col="datetime", parse_dates=True)
        df = df.rename(columns=COLUMN_ALIASES)
        if "anomaly" not in df.columns:
            df["anomaly"] = 0
        if "changepoint" not in df.columns:
            df["changepoint"] = 0
        df["source_file"] = os.path.basename(f)
        dfs.append(df)

    full_df = pd.concat(dfs, ignore_index=False)
    print(f"OK Cargados {len(files)} ficheros - {len(full_df):,} filas totales")
    return full_df


def split_normal_anomalous(df: pd.DataFrame):
    """
    Separa filas normales de anómalas.

    - normal_df  → usado para ENTRENAR el autoencoder
    - anomaly_df → usado para EVALUAR la detección

    La lógica de aprendizaje no supervisado es:
    el modelo solo ve datos normales en train y aprende a reconstruirlos.
    Cuando ve una anomalía, el error de reconstrucción sube.
    """
    normal_df = df[df["anomaly"] == 0][SENSOR_COLS].copy()
    anomaly_df = df[df["anomaly"] == 1][SENSOR_COLS].copy()

    print(f"   Filas normales : {len(normal_df):,} ({len(normal_df)/len(df)*100:.1f}%)")
    print(f"   Filas anómalas : {len(anomaly_df):,} ({len(anomaly_df)/len(df)*100:.1f}%)")
    return normal_df, anomaly_df


def fit_scaler(normal_df: pd.DataFrame) -> MinMaxScaler:
    """
    Ajusta un MinMaxScaler SOLO con datos normales.
    Importante: nunca fitear con datos anómalos para no contaminar la escala.
    """
    scaler = MinMaxScaler()
    scaler.fit(normal_df[SENSOR_COLS])
    return scaler


def create_windows(data: np.ndarray, window_size: int, step: int = 1) -> np.ndarray:
    """
    Crea ventanas deslizantes sobre la serie temporal.

    Parámetros
    ----------
    data        : array (n_timesteps, n_features)
    window_size : número de pasos temporales por ventana
    step        : desplazamiento entre ventanas (1 = máximo solapamiento)

    Devuelve
    --------
    array (n_windows, window_size, n_features)
    """
    windows = []
    for i in range(0, len(data) - window_size + 1, step):
        windows.append(data[i : i + window_size])
    return np.array(windows)


class SensorWindowDataset(Dataset):
    """
    Dataset de PyTorch para ventanas de series temporales de sensores.
    Devuelve (ventana, ventana) para entrenamiento de autoencoder
    (input == target en reconstrucción).
    """

    def __init__(self, windows: np.ndarray):
        self.windows = torch.tensor(windows, dtype=torch.float32)

    def __len__(self):
        return len(self.windows)

    def __getitem__(self, idx):
        x = self.windows[idx]
        return x, x  # autoencoder: target = input


def prepare_dataloaders(
    data_dir: str,
    window_size: int = 30,
    step: int = 1,
    batch_size: int = 64,
    val_split: float = 0.15,
):
    """
    Pipeline completo: carga → split → escala → ventanas → DataLoaders.

    Devuelve
    --------
    train_loader, val_loader : DataLoaders con datos normales
    test_data                : dict con arrays escalados para evaluación
    scaler                   : MinMaxScaler ajustado (para invertir si necesario)
    full_df                  : DataFrame completo con etiquetas (para métricas)
    """
    # 1. Carga
    full_df = load_skab_files(data_dir)

    # 2. Split normal / anómalo
    normal_df, _ = split_normal_anomalous(full_df)

    # 3. Escalado (fit solo con normales)
    scaler = fit_scaler(normal_df)

    normal_scaled = scaler.transform(normal_df[SENSOR_COLS])
    full_scaled = scaler.transform(full_df[SENSOR_COLS].ffill())

    # 4. Ventanas
    normal_windows = create_windows(normal_scaled, window_size, step)

    # Split train / val dentro de los datos normales
    n_val = int(len(normal_windows) * val_split)
    n_train = len(normal_windows) - n_val

    train_windows = normal_windows[:n_train]
    val_windows = normal_windows[n_train:]

    print(f"\nVentanas - train: {len(train_windows):,} | val: {len(val_windows):,}")

    # 5. DataLoaders
    train_loader = DataLoader(
        SensorWindowDataset(train_windows),
        batch_size=batch_size,
        shuffle=True,
        drop_last=True,
    )
    val_loader = DataLoader(
        SensorWindowDataset(val_windows),
        batch_size=batch_size,
        shuffle=False,
    )

    # 6. Datos de test completos (con anomalías) para evaluación
    test_data = {
        "windows": create_windows(full_scaled, window_size, step),
        "labels": full_df["anomaly"].values[window_size - 1 :],
        "sensor_cols": SENSOR_COLS,
    }

    return train_loader, val_loader, test_data, scaler, full_df
