"""
src/models.py
-------------
Definición de los autoencoders:
  - ConvAE   : Convolutional Autoencoder (mejor F1 en SKAB)
  - LSTMAE   : LSTM Autoencoder (mejor para patrones temporales largos)

Ambos exponen `reconstruction_error_per_variable()` como interfaz
hacia el sistema experto futuro.
"""

import torch
import torch.nn as nn


# ---------------------------------------------------------------------------
# Conv-AE
# ---------------------------------------------------------------------------

class ConvAE(nn.Module):
    """
    Autoencoder convolucional 1D para series temporales multivariadas.

    Arquitectura:
        Encoder: Conv1d → ReLU → Conv1d → ReLU  (comprime tiempo)
        Decoder: ConvTranspose1d → ReLU → ConvTranspose1d  (reconstruye)

    Parámetros
    ----------
    n_features  : número de variables de sensor (8 en SKAB)
    window_size : longitud de la ventana temporal
    latent_dim  : dimensión del espacio latente
    """

    def __init__(self, n_features: int = 8, window_size: int = 30, latent_dim: int = 16):
        super().__init__()
        self.n_features = n_features
        self.window_size = window_size

        # Encoder
        self.encoder = nn.Sequential(
            nn.Conv1d(n_features, 32, kernel_size=3, padding=1),
            nn.ReLU(),
            nn.Conv1d(32, 16, kernel_size=3, padding=1),
            nn.ReLU(),
            nn.Conv1d(16, latent_dim, kernel_size=3, padding=1),
            nn.ReLU(),
        )

        # Decoder (reconstruye hacia n_features)
        self.decoder = nn.Sequential(
            nn.ConvTranspose1d(latent_dim, 16, kernel_size=3, padding=1),
            nn.ReLU(),
            nn.ConvTranspose1d(16, 32, kernel_size=3, padding=1),
            nn.ReLU(),
            nn.ConvTranspose1d(32, n_features, kernel_size=3, padding=1),
            nn.Sigmoid(),  # salida entre 0 y 1 (datos están MinMax escalados)
        )

    def forward(self, x):
        # x: (batch, window_size, n_features)
        # Conv1d espera (batch, channels, length) → transponemos
        x = x.permute(0, 2, 1)       # → (batch, n_features, window_size)
        z = self.encoder(x)           # → (batch, latent_dim, window_size)
        x_hat = self.decoder(z)       # → (batch, n_features, window_size)
        x_hat = x_hat.permute(0, 2, 1)  # → (batch, window_size, n_features)
        return x_hat

    def reconstruction_error_per_variable(self, x: torch.Tensor) -> dict:
        """
        Calcula el MSE de reconstrucción para cada variable de sensor.

        Interfaz hacia el sistema experto:
        devuelve un dict {nombre_variable: score_anomalía}
        que las reglas pueden usar directamente.

        Parámetros
        ----------
        x : tensor (batch, window_size, n_features)

        Devuelve
        --------
        dict {"Current": 0.043, "Pressure": 0.001, ...}
        """
        self.eval()
        with torch.no_grad():
            x_hat = self.forward(x)
            # MSE por variable: media sobre batch y ventana temporal
            errors = ((x - x_hat) ** 2).mean(dim=(0, 1))  # (n_features,)
        return errors  # tensor de n_features valores


# ---------------------------------------------------------------------------
# LSTM-AE
# ---------------------------------------------------------------------------

class LSTMAE(nn.Module):
    """
    Autoencoder basado en LSTM para series temporales multivariadas.

    Arquitectura:
        Encoder: LSTM → toma el último hidden state como representación
        Decoder: repite el estado latente → LSTM → Dense

    Parámetros
    ----------
    n_features  : número de variables de sensor
    window_size : longitud de la ventana temporal
    hidden_dim  : dimensión del estado oculto del LSTM
    n_layers    : número de capas LSTM apiladas
    """

    def __init__(
        self,
        n_features: int = 8,
        window_size: int = 30,
        hidden_dim: int = 64,
        n_layers: int = 2,
    ):
        super().__init__()
        self.n_features = n_features
        self.window_size = window_size
        self.hidden_dim = hidden_dim

        # Encoder LSTM
        self.encoder_lstm = nn.LSTM(
            input_size=n_features,
            hidden_size=hidden_dim,
            num_layers=n_layers,
            batch_first=True,
            dropout=0.2 if n_layers > 1 else 0,
        )

        # Decoder LSTM (recibe el estado latente repetido)
        self.decoder_lstm = nn.LSTM(
            input_size=hidden_dim,
            hidden_size=hidden_dim,
            num_layers=n_layers,
            batch_first=True,
            dropout=0.2 if n_layers > 1 else 0,
        )

        # Proyección final al espacio de variables originales
        self.output_layer = nn.Sequential(
            nn.Linear(hidden_dim, n_features),
            nn.Sigmoid(),
        )

    def forward(self, x):
        # x: (batch, window_size, n_features)

        # Encoder: procesa la secuencia, extrae último hidden state
        _, (hidden, _) = self.encoder_lstm(x)
        # hidden: (n_layers, batch, hidden_dim) → tomamos la última capa
        z = hidden[-1]  # (batch, hidden_dim)

        # Decoder: repite z en el eje temporal y lo decodifica
        z_repeated = z.unsqueeze(1).repeat(1, self.window_size, 1)
        # z_repeated: (batch, window_size, hidden_dim)

        decoder_out, _ = self.decoder_lstm(z_repeated)
        # decoder_out: (batch, window_size, hidden_dim)

        x_hat = self.output_layer(decoder_out)
        # x_hat: (batch, window_size, n_features)
        return x_hat

    def reconstruction_error_per_variable(self, x: torch.Tensor) -> dict:
        """
        Misma interfaz que ConvAE — compatible con el sistema experto.
        """
        self.eval()
        with torch.no_grad():
            x_hat = self.forward(x)
            errors = ((x - x_hat) ** 2).mean(dim=(0, 1))
        return errors
