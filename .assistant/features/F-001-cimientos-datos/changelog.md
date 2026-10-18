# F-001 — Development Log
## 2026-10-14
### Changed
Creada la feature: spec (DRAFT), opciones de arquitectura de ingesta y plan de bloques BLK-001…006.
### Why
Bloque B0 del plan inicial: cerrar el contrato antes de escribir código.
### Tests
Ninguno (no hay código).
### Review
Pendiente de validación por el equipo.
### Audit
N/A
### Known issues
Decisiones abiertas D-02, D-03, D-04 y D-09, y supuestos BR-004, BR-009, Q-01 y Q-02.
### Next
Aceptar ADR-003/004/005, decidir la opción de ingesta (ADR-006), completar design.md e iniciar BLK-001.

## 2026-10-16
### Changed
- Validación de EXOS sobre las decisiones abiertas:
  - D-04: `discreto` = contador por pasos enteros.
  - Cerradas D-05, D-06, D-11, D-13, D-14 y D-15.
  - D-02 pasa a EN CURSO: hay datos reales en MESView.
- ADR-005 reescrito: los contadores (`incremental` y `discreto`) comparten `t32.incremento_bucket`, y los continuous aggregates quedan solo para `magnitud`.
- ADR-004: los datos reales de MESView pasan a ser la fuente principal; SKAB y la planta sintética quedan como apoyo con etiquetas.
- Spec: nuevos FR-013 (exportador MESView), BR-012 (contadores) y BR-013 (zona horaria); AC-005 ampliado.
- Plan: nuevo BLK-007 (exportador MESView), condicionado a D-02.
- OpenAPI: `Agregado` sustituye `consumo`/`ultimo`/`cambios` por `incremento`/`resets`/`deltas_no_enteros`.
### Why
Se incorporan las respuestas de EXOS a OPEN-DECISIONS.
### Tests
Ninguno (no hay código).
### Known issues
Siguen abiertas D-02 (copia de la BD), D-03 (Node-RED), D-07, D-08, D-09, D-10 (en parte), D-12 y D-16.
### Next
Aceptar ADR-003/004/005 y elegir la opción de ingesta (ADR-006). Después, BLK-001.

## 2026-10-16 — BLK-001
### Changed
- EXOS acepta ADR-003, ADR-004 y ADR-005 y la opción A de ingesta (ADR-006).
- ADR-002 revisado: Spring Boot 4.1, porque la 3.x ya no se ofrece.
- `infra/docker-compose.yml` con TimescaleDB 2.26.4-pg16 en loopback, en el puerto 55432.
- Esqueleto `svc-energy-rules`: Boot 4.1.1, Java 21, Flyway con el esquema `t32`, `V1__extensions.sql`, sesión JDBC en UTC y Actuator.
- Tests `SchemaBootstrapTests` e `ImageVersionConsistencyTest`.
- `design.md` completado.
### Why
Cimientos locales de F-001 (plan, BLK-001).
### Tests
`./mvnw -B verify`: 5 tests, 0 fallos. Arranque manual contra docker-compose con health en `UP` (ver tests.md).
### Review
Auto-revisión. La auditoría externa se hará al cerrar F-001.
### Audit
Pendiente.
### Known issues
`V1` requiere el privilegio `CREATE EXTENSION`.
### Next
BLK-002 (migraciones del contrato). BLK-006 (dataset-builder) se puede hacer en paralelo.
