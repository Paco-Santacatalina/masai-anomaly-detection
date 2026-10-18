# F-001 — Implementation Plan (B1)

Precondiciones para empezar BLK-001:
- `spec.md` aprobada;
- ADR-003, ADR-004 y ADR-005 en estado `Accepted`;
- decisión humana en `architecture-options.md`.

## BLK-001 — Entorno local y esqueleto de `svc-energy-rules`
### Purpose
Levantar TimescaleDB y un servicio Spring Boot vacío con un health check.
### Requirements
AC-001, NFR-005, NFR-006
### Dependencies
ADR-002
### Inputs
—
### Outputs
- `infra/docker-compose.yml` (imagen `timescale/timescaledb` fijada, pg16, volumen nombrado, healthcheck) y `infra/.env.example`.
- `svc-energy-rules/` con Maven Wrapper, Spring Boot 3, Actuator, Flyway, JDBC/JPA, Testcontainers y `--release 21`.
- `V1__extensions.sql` (`timescaledb`, `btree_gist`, esquema `t32`).
### Files/components
`infra/*`, `svc-energy-rules/pom.xml`, `src/main/resources/application.yml`, `db/migration/V1__*.sql`
### Risks
- La versión de la imagen TimescaleDB podría no estar disponible. Se fija tras comprobar el tag.
- Docker Desktop o Testcontainers en Windows.
### Tests
Test de contexto con Testcontainers: migraciones aplicadas y extensión `timescaledb` presente.
### Acceptance conditions
- `./mvnw verify` pasa.
- `docker compose up` deja la base de datos en estado *healthy*.

## BLK-002 — Esquema del contrato (migraciones)
### Purpose
Crear las tablas del contrato con todas sus restricciones.
### Requirements
FR-001…FR-005, BR-001/002/006/007/008/010
### Dependencies
BLK-001
### Inputs
`spec.md`, ADR-003
### Outputs
- `V2__catalogo.sql`: `centro_energetico`, `propiedad_energetica`, `centro_propiedad`, enum `tipo_agregacion`.
- `V3__medida_energia.sql`:
  - hypertable sobre `ts`;
  - `UNIQUE(centro_id, propiedad_id, ts)`;
  - índice `(centro_id, propiedad_id, ts DESC)`;
  - `calidad` como enum;
  - CHECK de valor finito.
- `V4__contexto_produccion.sql`: `periodo tstzrange` generado o `EXCLUDE USING gist (centro_id WITH =, periodo WITH &&)` y CHECK `ts_fin > ts_inicio`.
- `V6__import_lote.sql`.
### Files/components
`db/migration/V2..V4, V6`
### Risks
- La constraint EXCLUDE con columnas text exige `btree_gist`.
- Las restricciones UNIQUE de una hypertable deben incluir la columna de tiempo; aquí ya la incluye.
### Tests
Tests de base de datos:
- que se rechazan solapes de contexto, `ts_fin <= ts_inicio`, enums inválidos, `potencia_nominal` negativa y FKs inexistentes;
- que se acepta un hueco temporal.
### Acceptance conditions
Las migraciones se aplican desde cero y todos los tests de restricciones pasan.

## BLK-003 — Agregación adaptativa
### Purpose
Agregados por `tipo_agregacion` (ADR-005).
### Requirements
FR-008, BR-006, AC-005
### Dependencies
BLK-002
### Outputs
- `V5__agregados.sql`:
  - Continuous aggregates de 15 min y 1 h solo para `magnitud`, con sus políticas de refresco.
  - Función `t32.incremento_bucket(centro, propiedades, desde, hasta, bucket)`, compartida por `incremental` y `discreto`, con corrección de reset (BR-012).
- Vista `t32.v_medida_contexto`, con el flag `normalizable` (FR-009, BR-003).
### Risks
- Las restricciones de los continuous aggregates (sin funciones de ventana).
- Los límites de bucket con huecos.
- Contadores que bajan por motivos distintos de un reset, como el reemplazo del contador.
### Tests
Fixtures calculadas a mano:
- avg/min/max;
- contador `incremental` con reset;
- contador `discreto` con saltos enteros y con un delta no entero;
- delta que cruza el límite del bucket;
- exclusión de `bad`, saltando la lectura en los contadores;
- medida sin contexto.
### Acceptance conditions
AC-005 y AC-006 verificados con tests.

## BLK-004 — Importador CSV (caso de uso + CLI + API)
### Purpose
Carga idempotente y trazable (opción A de `architecture-options.md`).
### Requirements
FR-006, FR-011, BR-001/004/009, ERR-001…005, AC-002…004, NFR-001/003
### Dependencies
BLK-002
### Outputs
- Paquete `ingest`: parser en streaming, validador por fila, COPY a staging, merge con recuentos y `import_lote`.
- CLI `--import`.
- `POST /api/v1/imports` y `GET /api/v1/imports/{id}`, con límite de tamaño.
### Risks
- Memoria con ficheros grandes.
- Zona horaria: rechazar timestamps sin offset.
- Política de conflicto de valor (supuesto BR-004).
### Tests
- Unitarios del validador: cada caso de ERR-002/003/004.
- Integración:
  - importación completa;
  - reimportación (0 insertadas);
  - fichero mixto con filas válidas e inválidas;
  - cabecera inválida;
  - fichero vacío;
  - límite de tamaño;
  - desorden temporal (se acepta).
### Acceptance conditions
AC-002, AC-003 y AC-004 pasan con datos generados por BLK-006.

## BLK-005 — API de consulta (catálogo y medidas)
### Purpose
Exponer las lecturas.
### Requirements
FR-007, FR-008, FR-009, FR-010, ERR-006…008, AC-007, NFR-002/004
### Dependencies
BLK-003 (agregados) y BLK-002
### Outputs
- Interfaces generadas desde `contracts/openapi/svc-energy-rules.yaml`.
- Controllers delgados, con servicios y repositorios en JDBC/JPA.
- `ProblemDetail` global.
### Risks
- Paginación estable por `ts` (se usa keyset con `ts`+`propiedad_id`).
- Rangos grandes.
### Tests
- Contrato: la respuesta cumple el OpenAPI.
- Filtros y paginación.
- 400/404/503.
- Que no se filtran trazas internas en los errores.
### Acceptance conditions
AC-007; los errores siguen NFR-004.

## BLK-006 — `tools/dataset-builder`
### Purpose
Generar datasets conformes al contrato (ADR-004).
### Requirements
FR-012, AC-008
### Dependencies
Formato CSV de `spec.md`. **Se puede desarrollar en paralelo a BLK-002…005.**
### Outputs
- `tools/dataset-builder/` (`pyproject.toml`): `skab_to_contract.py`, `synthetic_plant.py` y `ground_truth.csv`.
### Risks
- Que el realismo de la planta sintética sea insuficiente; se mitiga con escenarios configurables.
- Python no está en el PATH: se usa el entorno conda o un venv.
### Tests
pytest:
- determinismo (`--seed`);
- esquema de los CSV;
- ausencia de solapes de contexto;
- anomalías inyectadas presentes en `ground_truth`.
### Acceptance conditions
- AC-008.
- Los CSV generados se importan sin rechazos (AC-002).

## BLK-007 — Exportador desde la copia de MESView
### Purpose
Producir CSV del contrato con datos reales (FR-013, ADR-004).
### Requirements
FR-013, BR-013, D-13, D-14, D-15
### Dependencies
- **D-02:** copia local de la BD y tabla identificada.
- BLK-006, para reutilizar el formato y el validador de los CSV.
### Inputs
Cadena de conexión a la **copia local** (variable de entorno; nunca producción) y rango de fechas.
### Outputs
`tools/dataset-builder/mesview_export.py`, que genera centros, propiedades, centro_propiedad, contexto (desde `medidahist`) y medidas.
### Risks
- Volumen de la tabla.
- Cambio de hora en Europe/Madrid.
- `centroequipo` es N:M (se usa `pordefecto`).
- Propiedades EAV en `varchar`.
### Tests
pytest contra una BD pequeña de fixture con:
- el mapeo de claves;
- la conversión de zona horaria, incluidos los dos días de cambio de hora;
- la aplicación de los factores;
- la ausencia de contexto.
### Acceptance conditions
La exportación de un rango de 1 semana se importa con BLK-004 sin rechazos inesperados, y los recuentos cuadran con la copia.

## Orden y paralelismo
```text
BLK-001 → BLK-002 → BLK-003 ─┐
                  └→ BLK-004 ─┼→ BLK-005
BLK-006 (en paralelo) ────────┤
BLK-007 (cuando se resuelva D-02) ┘
```
Cada bloque cierra con 08 code review, 10 tests ejecutados con evidencia y 12 changelog. Al terminar F-001 se hacen 06 integración, 07 seguridad y 09 auditoría externa.
