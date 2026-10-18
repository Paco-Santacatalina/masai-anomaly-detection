# F-001 — Architecture Options: mecanismo de ingesta y agregación

## Constraints
- La propiedad del esquema `t32` y de sus migraciones es de `svc-energy-rules` (ADR-001/002).
- Las reglas de validación (BR-001…BR-011) deben aplicarse **en un único sitio**.
- La importación tiene que ser idempotente y trazable (`import_lote`).
- La agregación adaptativa sigue ADR-005.
- El equipo es pequeño, así que conviene minimizar las piezas.

## Option A — Importador en `svc-energy-rules` (Java) con staging + merge SQL
### Structure
- Módulo `ingest` con:
  - un parser CSV en streaming (Jackson CSV o Commons CSV);
  - validación por fila en Java;
  - `COPY` a una tabla temporal de staging (`PgConnection.getCopyAPI`);
  - `INSERT … SELECT … ON CONFLICT DO NOTHING` hacia `medida_energia`, con recuento de insertadas y duplicadas.
- Las entradas son CLI (`ApplicationRunner`) y `POST /api/v1/imports`. Las dos usan el mismo caso de uso.
### Data flow
CSV → parser → validador (rechazos al `import_lote`) → COPY a staging → merge → resumen del lote.
### Advantages
- Las reglas de validación quedan en un solo lugar, el mismo servicio que es dueño del esquema.
- Rendimiento alto gracias a COPY.
- Se prueba con Testcontainers.
- La API y la CLI comparten el código.
### Disadvantages
- Hace falta JDBC "a mano" para COPY y merge; JPA no sirve para cargas masivas.
- No lee Parquet de forma nativa.
### Risks
- Memoria con ficheros grandes. Se mitiga con streaming y lotes.

## Option B — Cargador Python en `tools/` que escribe directamente en la base de datos
### Structure
`dataset-builder` valida con pandas o pydantic y escribe con `psycopg COPY`. El servicio Java solo lee.
### Data flow
CSV/Parquet → Python → TimescaleDB.
### Advantages
- Lee Parquet de forma nativa.
- Reutiliza el ecosistema pandas.
- Es rápido de escribir.
### Disadvantages
- Las reglas del contrato acaban duplicadas o divididas entre Python y Java.
- Un segundo escritor del esquema rompe la propiedad de los datos.
- No hay API de importación.
### Risks
- Que la validación de los dos lenguajes diverja.
- Que haya cambios de esquema que Python no conozca.

## Option C — Carga SQL pura (`psql \copy` + procedimientos almacenados)
### Structure
Scripts `\copy` hacia staging, más procedimientos PL/pgSQL `t32.importar_medidas()` que validan y fusionan.
### Data flow
CSV → `psql` → staging → procedimiento → tablas.
### Advantages
- Máximo rendimiento.
- No necesita código de aplicación para la carga.
### Disadvantages
- La lógica de negocio queda en PL/pgSQL, más difícil de probar y de revisar.
- Los mensajes de error por fila son pobres.
- No hay API.
### Risks
- La mantenibilidad (skill 08: "¿otro ingeniero podría explicarlo?").

## Comparison
| Criterion | A | B | C |
|---|---|---|---|
| Complexity | Media | Baja | Media |
| Testability | Alta (Testcontainers) | Media | Baja-media |
| Scalability | Alta (COPY) | Alta | Muy alta |
| Security | Alta (un solo escritor, validación central) | Media (otro escritor con credenciales de escritura) | Media |
| Operations | Una sola pieza | Dos pipelines | Scripts más BD |
| Cost | Medio | Bajo | Medio |
| Reversibility | Alta | Media | Media |

## Agregación (común a todas las opciones)
Se aplica ADR-005:
- continuous aggregates para `magnitud`;
- función `t32.incremento_bucket` para los contadores (`incremental` y `discreto`), sobre los datos crudos;
- se materializa más adelante solo si NFR-002 no se cumple con los datos de prueba.

## Recommendation
**Opción A.** El único escritor del esquema es el servicio que es dueño de él, la validación está en un solo sitio y CLI y API comparten el caso de uso. Parquet se resuelve convirtiendo a CSV en `dataset-builder`, que no escribe en la base de datos.

## Human decision
**Opción A**, aceptada por EXOS el 2026-10-16.

## ADR
ADR-006-ingesta-java.md
