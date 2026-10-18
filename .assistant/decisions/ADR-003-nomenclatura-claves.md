# ADR-003 — Nomenclatura de tablas y claves de negocio del contrato de datos
Status: Accepted (2026-10-16)
Date: 2026-10-14

## Context
El funcional (§6.1) llama `medida` a la hypertable de lecturas y (§6.3) propone mapear `Medida`→`medida`. Pero el análisis de `db/mesview/script.sql` muestra otra cosa:
- En MESView, `medida`/`medidahist` son **intervalos de estado y producción** (OEE): `finicio`, `ffin`, `tipomedida='estados'`, `centroestado_fk`. **No son lecturas de energía.**
- Las lecturas de energía están en `equipopropiedadvalor` (`fecha timestamptz`, `valor_double`, con `factor_multiplicativo`/`factor_offset` en `equipopropiedad`) y en `energiamedida` (intervalos por contador, con `turno_fk`, en `timestamp` sin zona).
- Los identificadores de MESView son `bigserial`. `centro` tiene un `codigo varchar(50)` legible.

Si se mantiene el nombre `medida`, la integración futura (B7) mezclaría dos conceptos distintos con el mismo nombre en una instancia TimescaleDB compartida.

## Decision
1. La hypertable de lecturas de T3.2 se llama **`medida_energia`**. El resto de entidades conserva su nombre del contrato: `centro_energetico`, `propiedad_energetica` y `contexto_produccion`.
2. Todo el contrato vive en un esquema propio **`t32`**.
3. `centro_id` es `text` y, en la integración, se alimenta con **`centro.codigo`** de MESView, no con `centro.id`.
4. `propiedad_id` es `text`, en `snake_case` estable (`consumo_electrico`, `consumo_gas`, `presion_aire`…). La correspondencia con `equipoclasepropiedad`/`energiacontadortipo` se resuelve en el job de sincronización de B7.
5. Se corrige el §6.3 del funcional: el origen de `medida_energia` es `equipopropiedadvalor` (ruta preferida) o `energiamedida`, **no** `medida`.

## Alternatives
- Mantener `medida`: fiel al texto del funcional, pero ambiguo frente a MESView.
- Usar los `bigint` de MESView como claves: rompe la regla del contrato (§6.4) de no depender de las PKs internas.

## Why this decision
Evita la colisión semántica y de nombres, y mantiene el desacoplamiento exigido por §6.4.

## Consequences
### Positive
- La integración es inequívoca y el esquema propio se puede eliminar sin afectar a MESView.
### Negative
- Hay que actualizar el funcional (§6.1 y §6.3).
- ~~Hay que confirmar con MESView que `centro.codigo` es único y estable.~~ Confirmado por EXOS el 2026-10-16 (D-13), junto con la ruta variable → centro.
- El origen exacto de `medida_energia` (punto 5) depende de qué tabla de MESView contiene los datos (D-02).

## Related features
F-001, F-007 (integración)
