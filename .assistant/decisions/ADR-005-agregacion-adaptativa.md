# ADR-005 — Diseño propio de la agregación adaptativa por tipo de variable
Status: Accepted (2026-10-16)
Date: 2026-10-14 (revisado 2026-10-16: semántica confirmada en D-04)

## Context
El funcional (§4, §7) propone reutilizar "el patrón de continuous aggregates y agregación adaptativa ya probado".

En el volcado `db/mesview/script.sql` no aparece ninguna hypertable ni ningún continuous aggregate. Puede que la herramienta de exportación no los incluya; se comprobará con la copia de la BD (D-12).

`tipo_agregacion_enum ('magnitud','incremental','discreto')` existe en `propiedadfamilia`, pero ninguna función del volcado lo usa. Lo más parecido es `total_consumo_bucket()`, que calcula `value - lag(value)` y luego `sum()` por `time_bucket`.

**Semántica confirmada por EXOS (D-04, 2026-10-16):**
- `incremental`: contador acumulado continuo, por ejemplo energía en kWh o volumen en m³.
- `discreto`: contador acumulado que crece **a saltos enteros**, por ejemplo piezas, ciclos o arranques.
- `magnitud`: valor instantáneo, por ejemplo potencia en kW, presión en bar o temperatura en °C.

## Decision
En el esquema `t32` se usan **los mismos valores de enum** que en MESView:

| tipo_agregacion | Significado del `valor` | Agregado por bucket |
|---|---|---|
| `magnitud` | Valor instantáneo | `avg`, `min`, `max`, `n` |
| `incremental` | Contador acumulado continuo | `incremento` = suma de deltas entre lecturas consecutivas dentro del bucket; `resets` |
| `discreto` | Contador acumulado por pasos enteros | Igual que `incremental`. Además, se marca como dato sospechoso (`calidad`) cualquier delta no entero |

**Tratamiento de los contadores (`incremental` y `discreto`):**
- El delta se calcula entre la lectura y la anterior de la misma serie, aunque la anterior caiga en otro bucket. El incremento se asigna al bucket de la lectura posterior.
- Un delta negativo se interpreta como **reset del contador**. Se toma como delta el valor posterior, suponiendo que el contador vuelve a 0, y se suma uno a `resets`.
- **Supuesto pendiente de validar:** un contador puede bajar por otros motivos, como el reemplazo de un contador o un error de lectura. Por eso se registra el número de resets, para que las reglas lo puedan vigilar.

**Implementación:**
- `magnitud`: continuous aggregates de TimescaleDB de 15 min y 1 h sobre `medida_energia`, con política de refresco.
- `incremental` y `discreto`: necesitan `lag()`, y las funciones de ventana no se permiten en continuous aggregates. Se resuelven con la función SQL `t32.incremento_bucket(centro, propiedades, desde, hasta, bucket)` sobre los datos crudos. Si el rendimiento medido no cumple NFR-002, se materializarán en una fase posterior.
- Las medidas con `calidad = 'bad'` no entran en los agregados. Se cuentan aparte en `n_bad`. En los contadores, una lectura `bad` se salta y el delta se calcula con la siguiente lectura válida.

## Alternatives
- **Esperar al patrón de MESView:** bloquea B1.
- **Agregar en Java:** más simple, pero mucho más lento y no aprovecha TimescaleDB.
- **Tratar `discreto` como estado o código:** EXOS lo ha descartado (D-04).

## Why this decision
- Desbloquea B1.
- Mantiene la semántica del enum de MESView.
- Concentra lo delicado, el reset de contadores, en una única función que se puede probar.

## Consequences
### Positive
- Las reglas (B2) y las features del DL (B5) reciben agregados coherentes con el tipo de variable.
- `incremental` y `discreto` comparten el mismo código.
### Negative
- Si MESView tiene un patrón propio distinto, habrá que reconciliarlo en B7 (D-12).
- No se modelan variables de estado (on/off, modo). Si aparecen, harán falta un nuevo valor de enum y un nuevo ADR.

## Related features
F-001, F-002 (reglas), F-005
