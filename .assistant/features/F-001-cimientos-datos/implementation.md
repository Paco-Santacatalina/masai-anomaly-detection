# F-001 — Implementation Status

## Overall status
IN PROGRESS: BLK-001 terminado.

## Requirement traceability
| Requirement | Evidence | Status |
|---|---|---|
| AC-001 | `SchemaBootstrapTests` (Testcontainers) y arranque manual contra docker-compose (ver tests.md) | DONE |
| NFR-005 | `TestcontainersConfiguration.TIMESCALEDB_IMAGE` + `ImageVersionConsistencyTest` | DONE |
| NFR-006 | `V1__extensions.sql` aplicada desde cero (`SchemaBootstrapTests.flywayCreatesSchemaAndAppliesBaselineMigration`) | DONE (baseline) |
| BR-001 (sesión UTC) | Hikari `connection-init-sql` + `SchemaBootstrapTests.sessionTimeZoneIsUtc` | DONE (sesión). La validación de entrada queda para BLK-004 |
| FR-001…FR-013 | — | TODO |

## Blocks
| Block | Status | Review |
|---|---|---|
| BLK-001 | DONE | Auto-revisión (skill 08). Auditoría externa al cerrar F-001 |
| BLK-002 | TODO | — |
| BLK-003 | TODO | — |
| BLK-004 | TODO | — |
| BLK-005 | TODO | — |
| BLK-006 | TODO | — |
| BLK-007 | BLOCKED (D-02) | — |

## Changed files
**BLK-001:**
- `infra/docker-compose.yml`, `infra/.env.example`.
- `svc-energy-rules/`: generado con Spring Initializr (Boot 4.1.1, Java 21) y ajustado:
  - `pom.xml`;
  - `application.yml`;
  - `db/migration/V1__extensions.sql`;
  - tests `SchemaBootstrapTests`, `ImageVersionConsistencyTest` y `TestcontainersConfiguration`.

## Deviations from design
- Spring Boot 4.1 en lugar de 3 (revisión de ADR-002).
- Puerto local 55432 en lugar de 5432.

## Known limitations
- `V1` necesita privilegios de `CREATE EXTENSION`. En entornos gestionados habrá que crear las extensiones fuera de banda.
- El `pom.xml` todavía no incluye openapi-generator: se añade en BLK-005.

## Follow-up
BLK-002 (esquema del contrato).
