"""
src/trainer.py
--------------
Bucle de entrenamiento con integración MLflow.
Registra hiperparámetros, métricas por época y el modelo final.
"""

import numpy as np
import torch
import torch.nn as nn
import mlflow
import mlflow.pytorch
from tqdm import tqdm


def train_epoch(model, loader, optimizer, criterion, device):
    """Una época de entrenamiento."""
    model.train()
    total_loss = 0.0
    for x, _ in loader:
        x = x.to(device)
        optimizer.zero_grad()
        x_hat = model(x)
        loss = criterion(x_hat, x)
        loss.backward()
        # Gradient clipping — evita explosión de gradientes en LSTM
        nn.utils.clip_grad_norm_(model.parameters(), max_norm=1.0)
        optimizer.step()
        total_loss += loss.item() * len(x)
    return total_loss / len(loader.dataset)


def val_epoch(model, loader, criterion, device):
    """Una época de validación."""
    model.eval()
    total_loss = 0.0
    with torch.no_grad():
        for x, _ in loader:
            x = x.to(device)
            x_hat = model(x)
            loss = criterion(x_hat, x)
            total_loss += loss.item() * len(x)
    return total_loss / len(loader.dataset)


def train(
    model,
    train_loader,
    val_loader,
    config: dict,
    experiment_name: str = "skab_anomaly_detection",
):
    """
    Entrenamiento completo con registro en MLflow.

    Parámetros
    ----------
    model        : ConvAE o LSTMAE
    train_loader : DataLoader con datos normales de entrenamiento
    val_loader   : DataLoader con datos normales de validación
    config       : dict con hiperparámetros del experimento
    experiment_name : nombre del experimento en MLflow

    Devuelve
    --------
    model entrenado, historial de pérdidas
    """
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    print(f"🖥️  Dispositivo: {device}")
    model = model.to(device)

    optimizer = torch.optim.Adam(
        model.parameters(),
        lr=config["learning_rate"],
        weight_decay=config.get("weight_decay", 1e-5),
    )

    # Scheduler: reduce lr si val_loss no mejora en 5 épocas
    scheduler = torch.optim.lr_scheduler.ReduceLROnPlateau(
        optimizer, mode="min", factor=0.5, patience=5, verbose=True
    )

    criterion = nn.MSELoss()

    # Early stopping
    best_val_loss = float("inf")
    patience_counter = 0
    best_model_state = None
    history = {"train_loss": [], "val_loss": []}

    # --- MLflow ---
    mlflow.set_experiment(experiment_name)

    with mlflow.start_run(run_name=config.get("run_name", model.__class__.__name__)):

        # Registrar hiperparámetros
        mlflow.log_params(config)
        mlflow.log_param("model_class", model.__class__.__name__)
        mlflow.log_param("device", str(device))
        mlflow.log_param("n_parameters", sum(p.numel() for p in model.parameters()))

        epochs = config["epochs"]
        patience = config.get("early_stopping_patience", 10)

        for epoch in tqdm(range(1, epochs + 1), desc="Entrenando"):
            train_loss = train_epoch(model, train_loader, optimizer, criterion, device)
            val_loss = val_epoch(model, val_loader, criterion, device)

            history["train_loss"].append(train_loss)
            history["val_loss"].append(val_loss)

            # Registrar métricas en MLflow
            mlflow.log_metrics(
                {"train_loss": train_loss, "val_loss": val_loss},
                step=epoch,
            )

            scheduler.step(val_loss)

            # Early stopping
            if val_loss < best_val_loss:
                best_val_loss = val_loss
                patience_counter = 0
                best_model_state = {
                    k: v.clone() for k, v in model.state_dict().items()
                }
            else:
                patience_counter += 1
                if patience_counter >= patience:
                    print(f"\n⏹️  Early stopping en época {epoch}")
                    break

            if epoch % 10 == 0:
                print(
                    f"Época {epoch:3d} | train: {train_loss:.5f} | val: {val_loss:.5f}"
                )

        # Cargar el mejor modelo encontrado
        if best_model_state:
            model.load_state_dict(best_model_state)
            print(f"\n✅ Mejor val_loss: {best_val_loss:.5f}")

        # Registrar el modelo en MLflow
        mlflow.log_metric("best_val_loss", best_val_loss)
        mlflow.pytorch.log_model(model, "model")

    return model, history
