# ADR-006 — Importación de datos en `svc-energy-rules` (staging + merge SQL)
Status: Accepted (2026-10-16)
Date: 2026-10-16

## Context
F-001 necesita cargar CSV del contrato de forma idempotente y trazable, con validación por fila (BR-001…BR-013). Las opciones se compararon en `.assistant/features/F-001-cimientos-datos/architecture-options.md`:
- **A:** importador Java dentro del servicio.
- **B:** cargador Python escribiendo directamente en la BD.
- **C:** solo SQL (`\copy` + PL/pgSQL).

## Decision
**Opción A.** El módulo `ingest` de `svc-energy-rules` funciona así:
1. Parsea el CSV en streaming y lo valida fila a fila en Java.
2. Hace `COPY` a una tabla temporal de staging.
3. Hace `INSERT … SELECT … ON CONFLICT DO NOTHING` contra las tablas del contrato, contando filas insertadas, duplicadas y en conflicto.
4. Registra el resultado en `import_lote`.

Se usa con el mismo caso de uso desde la CLI y desde `POST /api/v1/imports`. Parquet no se lee directamente: `tools/dataset-builder` lo convierte antes a CSV y nunca escribe en la BD.

## Alternatives
- **B:** duplica las reglas del contrato en dos lenguajes y añade un segundo escritor del esquema.
- **C:** deja la lógica de negocio en PL/pgSQL, que es difícil de probar, da errores pobres por fila y no ofrece API.

## Why this decision
- Un único escritor del esquema `t32`, que además es su propietario (ADR-001).
- La validación está en un solo sitio.
- El rendimiento de COPY es alto.
- Se prueba con Testcontainers.

## Consequences
### Positive
- La CLI y la API comparten código.
- Cada lote queda registrado.
### Negative
- COPY y merge van con JDBC directo, no con JPA.
- Las herramientas Python solo generan ficheros.

## Related features
F-001 (BLK-004), F-007
