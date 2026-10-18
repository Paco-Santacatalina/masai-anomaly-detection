# F-001 — Selected Technical Design

## Selected architecture
Opción A (ADR-006), dentro de la arquitectura de dos servicios (ADR-001) y con el stack de ADR-002: Spring Boot 4.1, Java 21, TimescaleDB 2.26.4 sobre PG16.

## Components
| Componente | Ubicación | Bloque |
|---|---|---|
| TimescaleDB local | `infra/docker-compose.yml` (imagen `timescale/timescaledb:2.26.4-pg16`, puerto `127.0.0.1:55432`) | BLK-001 |
| Esqueleto del servicio | `svc-energy-rules/` (paquete `es.exos.masai.energy.rules`) | BLK-001 |
| Migraciones | `svc-energy-rules/src/main/resources/db/migration/V*.sql` (esquema `t32`) | BLK-001…003 |
| `catalog`, `measurement` | paquetes del dominio en `svc-energy-rules` | BLK-005 |
| `ingest` | paquete `ingest` (parser → validador → COPY a staging → merge → `import_lote`) | BLK-004 |
| `dataset-builder` | `tools/dataset-builder/` (Python) | BLK-006/007 |

## Data flow
```text
CSV ──(CLI | POST /api/v1/imports)──> ingest ──COPY──> staging ──merge──> t32.* ──> import_lote
                                                                           │
GET /api/v1/centros/{id}/medidas ── measurement ── crudo | cagg (magnitud) | t32.incremento_bucket()
```

## Backend
- Los controllers solo orquestan; la lógica vive en los servicios (skill 13).
- JPA para el catálogo; JDBC directo para COPY, merge y consultas sobre series.

## API
`contracts/openapi/svc-energy-rules.yaml`. Las interfaces se generan desde el contrato en BLK-005.

## Database
- Esquema `t32`, creado por Flyway (`create-schemas`). Las extensiones `timescaledb` y `btree_gist` se instalan en `public` (V1).
- Hibernate `ddl-auto: none`: el esquema lo gestiona solo Flyway.
- Cada sesión JDBC ejecuta `SET TIME ZONE 'UTC'` (Hikari `connection-init-sql`). PgJDBC enviaría si no la zona de la JVM, que en los equipos del equipo es Europe/Madrid (BR-001).

## Integrations
Ninguna en F-001. La exportación desde MESView (BLK-007) trabaja sobre una copia local.

## Security
- La BD local solo escucha en loopback.
- La contraseña va en `infra/.env` (ignorado por git) y no hay secretos en el repo.
- La API no tiene autenticación, a la espera de D-08.
- `show-details: never` en el endpoint de salud.

## Observability
Por ahora, Actuator `health` e `info`. Logs JSON y correlation id según D-11, a partir de BLK-004.

## Failure modes
- BD caída: el arranque falla, porque Flyway no puede migrar. En ejecución, health pasa a `DOWN` y las consultas devuelven 503 (ERR-008, BLK-005).
- Puerto local ocupado: el puerto se configura con `T32_DB_PORT`. Por defecto es el 55432, porque el 5432 lo usa un PostgreSQL local.

## Migration
Flyway versionado. Las migraciones aplicadas no se modifican nunca; cualquier cambio va en una migración nueva.

## Rollback
Local: `docker compose down -v` recrea la BD desde cero.

## ADRs
ADR-001 a ADR-006
