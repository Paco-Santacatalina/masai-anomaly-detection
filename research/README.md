nomaly Detection — Fase 1
Detección de anomalías en series temporales industriales con Conv-AE y LSTM-AE.
Interfaz preparada para integración futura con sistema experto basado en reglas.
Estructura del proyecto
skab_anomaly/
├── environment.yml          ← Entorno Miniconda
├── data/                    ← Datasets de SKAB (descargar aparte)
├── notebooks/
│   └── 01_experiment.ipynb  ← Notebook principal
├── src/
│   ├── data_loader.py       ← Carga y preprocesado
│   ├── models.py            ← ConvAE y LSTMAE
│   ├── trainer.py           ← Bucle de entrenamiento + MLflow
│   └── evaluator.py        ← Métricas + interfaz sistema experto
└── mlruns/                  ← Experimentos MLflow (se genera automáticamente)
Setup paso a paso
1. Crear el entorno Miniconda
bashconda env create -f environment.yml
conda activate skab-anomaly
2. Registrar el kernel en VS Code
bashpython -m ipykernel install --user --name skab-anomaly --display-name "skab-anomaly"
Luego en VS Code: Ctrl+Shift+P → "Select Kernel" → selecciona skab-anomaly.
3. Descargar los datos de SKAB
bash# Dentro de la carpeta del proyecto:
svn export https://github.com/waico/SKAB/trunk/data ./data
4. Lanzar MLflow UI
En una terminal separada (con el entorno activado):
bashconda activate skab-anomaly
mlflow ui
Abre http://localhost:5000 en el navegador para ver los experimentos.
5. Ejecutar el notebook
Abre notebooks/01_experiment.ipynb en VS Code y ejecuta celda a celda.
Flujo de trabajo
Solo datos normales → Entrenamiento autoencoder → Error de reconstrucción
                                                          ↓
                              Error por variable → Interfaz sistema experto
                              Error global      → Umbral → Predicción binaria
                                                          ↓
                                              Métricas (F1, FAR, MAR)
                                              registradas en MLflow
Referencia de resultados SKAB (leaderboard oficial)
ModeloF1FAR %MAR %Conv-AE0.7813.5528.02LSTM-AE0.7429.9625.92LSTM-VAE0.569.1355.03