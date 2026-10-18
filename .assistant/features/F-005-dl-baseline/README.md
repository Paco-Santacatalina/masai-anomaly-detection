# F-005 — `svc-energy-dl` baseline
Status: PROPOSED (bloque B5; no se implementa en la Fase 1)

## Summary
Convertir el prototipo `research/` (ConvAE/LSTMAE sobre SKAB) en un servicio FastAPI de scoring por centro, según `contracts/openapi/svc-energy-dl.yaml`.

## Related ADRs
ADR-001, ADR-002, ADR-004

## Modelos a evaluar (D-10, 2026-10-16)
Primero, los ya probados con SKAB: **ConvAE** como principal y **LSTMAE** como alternativa, una vez corregidos los defectos de abajo. Se comparan con la referencia publicada de SKAB y después con los datos reales y la planta sintética. Antes de entrenar con datos reales hay que resolver DL-07.

## Backlog técnico heredado del prototipo
Fuentes: funcional §11, plan inicial §2 y revisión del 2026-10-14. Las referencias apuntan a `research/src/`.

| ID | Defecto | Ubicación | Impacto |
|---|---|---|---|
| DL-01 | `SENSOR_COLS` está fijado a SKAB | `data_loader.py` | No admite variables dinámicas por centro. Debe leerse de `centro_propiedad` |
| DL-02 | El umbral por variable sale del test normal aunque se pasen `train_errors`; las dos ramas son idénticas | `evaluator.py::evaluate` | Los umbrales que recibe el sistema experto están sesgados |
| DL-03 | Las ventanas se crean sobre el DataFrame concatenado y cruzan experimentos y centros | `data_loader.py::prepare_dataloaders` | Ventanas artificiales |
| DL-04 | `create_windows(normal_scaled)` se aplica después de quitar las filas anómalas, así que las ventanas saltan huecos | `data_loader.py` | Entrena con secuencias que no existen |
| DL-05 | Usa un `MinMaxScaler` global | `data_loader.py::fit_scaler` | Mezcla rangos de equipos distintos. Debe haber uno por `centro_id`/`tipo_equipo` |
| DL-06 | El test incluye las filas normales usadas en el entrenamiento (fuga de datos) y no hay partición por experimento | `data_loader.py`, `evaluator.py` | Métricas optimistas |
| DL-07 | No hay normalización por `contexto_produccion` | — | Confunde un parón de producción con eficiencia. **Bloquea el uso con datos reales** |
| DL-08 | `reconstruction_error_per_variable()` devuelve un tensor, no el dict que documenta | `models.py` | Contrato roto |
| DL-09 | `confusion_matrix(...).ravel()` falla si solo hay una clase | `evaluator.py` | Excepción en series sin anomalías |
| DL-10 | El latente de ConvAE (latent_dim × window) es mayor que la entrada (8 × window); no comprime en el eje temporal | `models.py::ConvAE` | Puede aprender casi la identidad |
| DL-11 | La salida `Sigmoid` satura los valores escalados fuera de [0,1] | `models.py::ConvAE` | Aplasta el score justo en las anomalías fuera de rango |
| DL-12 | `ReduceLROnPlateau(verbose=True)` está deprecado o eliminado en PyTorch reciente | `trainer.py` | Fallo al actualizar dependencias |
| DL-13 | No hay semillas fijas ni lógica de promoción de modelo | `trainer.py` | No es reproducible. La promoción se aborda en B7 |
| DL-14 | No hay tests | — | — |
| DL-15 | Asume muestreo regular | `data_loader.py` | Incumple §6.4: el DL debe tolerar huecos |

## Criterio de aceptación de B5 (del plan inicial)
Para el mismo modelo y la misma entrada, el endpoint devuelve el score global, el score por variable, la versión del modelo y los timestamps de referencia. Las métricas se calculan con particiones por serie o experimento, sin fuga temporal.
