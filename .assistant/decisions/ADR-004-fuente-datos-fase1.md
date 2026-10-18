# ADR-004 — Fuente de datos de la Fase 1: datos reales de MESView, más SKAB y planta sintética como apoyo
Status: Accepted (2026-10-16)
Date: 2026-10-14 (revisado 2026-10-16)

## Context
- `db/mesview/script.sql` solo muestra el **modelo** de datos y está vacío a propósito. EXOS confirma (2026-10-16) que en la BD de MESView **sí hay una tabla con datos reales**. Falta conseguir una copia e identificar la tabla (D-02).
- Esos datos los escribe un **flujo Node-RED**, cuya frecuencia de muestreo y política de envío todavía no conocemos (D-03).
- Los datos reales **no traen etiquetas de anomalía**, así que sirven para entrenar (no supervisado) y para validar el valor práctico, pero no para medir F1/FAR/MAR de forma objetiva.
- SKAB es un banco de bombas: tiene etiquetas, pero no es consumo energético de planta ni incluye contexto productivo.

## Decision
Se usan tres fuentes, cada una con un propósito distinto:
1. **Datos reales de MESView (fuente principal).**
   - Se exporta la tabla identificada, más el catálogo (centros, propiedades) y el contexto (`medidahist`), a CSV conforme al contrato.
   - La exportación la hace un script de `tools/` que lee de la **copia local** y aplica el mapeo de ADR-003, D-13, D-14 y D-15. No conecta nunca con producción.
   - Servirá para entrenar el DL, calibrar umbrales y baselines y validar el valor práctico con el feedback de EXOS.
2. **SKAB → contrato** (`skab_to_contract`).
   - Cada experimento pasa a ser un `centro_id` y cada una de las 8 columnas una `propiedad_energetica` de tipo `magnitud`.
   - Las etiquetas van a un fichero aparte de *ground truth*.
   - Sirve para comparar ConvAE y LSTMAE con la referencia publicada de SKAB (D-10) y para validar la mecánica del DL.
3. **Planta sintética** (`synthetic_plant`, semilla fija).
   - Genera contadores `incremental` y `discreto`, magnitudes y contexto productivo.
   - Inyecta anomalías etiquetadas: consumo con la línea parada, fugas, derivas y picos sobre la potencia nominal.
   - Sirve para los tests de integración y para medir reglas y fusión con un *ground truth*. Mientras no llegue la copia de la BD, es la fuente con la que avanza B1.

## Alternatives
- **Usar solo datos reales:** no permite medir la detección de forma objetiva, porque no hay etiquetas, y bloquea B1 hasta tener la copia.
- **Usar solo SKAB:** no cubre contadores ni contexto productivo.

## Why this decision
Los datos reales responden a si el sistema es útil; SKAB y la planta sintética responden a si detecta lo que debe detectar. Hacen falta las tres fuentes.

## Consequences
### Positive
- B1 avanza sin esperar a la copia, y el exportador de MESView adelanta parte de B7 (la sincronización).
### Negative
- El generador sintético incorpora nuestras propias hipótesis. Un buen rendimiento sobre él **no demuestra valor en datos reales** (skill 15).
- Con datos reales, la precisión solo se podrá medir a partir del feedback acumulado (B6).

## Related features
F-001, F-005, F-007
