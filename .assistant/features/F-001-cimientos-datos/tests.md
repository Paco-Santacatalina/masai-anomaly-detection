# F-001 — Test Evidence

## Coverage matrix
| Requirement | Test | Type | Result |
|---|---|---|---|
| AC-001 | `SchemaBootstrapTests.flywayCreatesSchemaAndAppliesBaselineMigration` | Integración (BD) | PASS |
| AC-001 | `SchemaBootstrapTests.requiredExtensionsAreInstalled` | Integración (BD) | PASS |
| AC-001 | `SchemaBootstrapTests.healthEndpointReportsUp` | Integración (HTTP) | PASS |
| BR-001 | `SchemaBootstrapTests.sessionTimeZoneIsUtc` | Integración (BD) | PASS |
| NFR-005 | `ImageVersionConsistencyTest.testcontainersImageMatchesDockerCompose` | Unitario | PASS |

## Edge cases
Pendiente (BLK-002 en adelante).

## Security tests
Pendiente.

## Integration tests
Testcontainers con la imagen `timescale/timescaledb:2.26.4-pg16`.

## AI/agent evaluations
N/A

## Executed commands
```text
# 2026-10-16 — BLK-001
cd svc-energy-rules
./mvnw -B verify

cp infra/.env.example infra/.env        # contraseña aleatoria generada
docker compose -f infra/docker-compose.yml --env-file infra/.env up -d
java -jar svc-energy-rules/target/svc-energy-rules-0.0.1-SNAPSHOT.jar --server.port=18080   # con las variables de infra/.env
curl http://localhost:18080/actuator/health
docker exec masai-t32-db psql -U t32 -d t32 -c "select * from t32.flyway_schema_history; select * from pg_extension;"
```

## Actual results
```text
./mvnw -B verify
  ImageVersionConsistencyTest  Tests run: 1, Failures: 0, Errors: 0
  SchemaBootstrapTests         Tests run: 4, Failures: 0, Errors: 0   (87 s, incluida la descarga de la imagen)
  Tests run: 5, Failures: 0, Errors: 0, Skipped: 0 — BUILD SUCCESS

docker compose: masai-t32-db healthy (127.0.0.1:55432)
Arranque: "Successfully applied 1 migration to schema "t32", now at version v1"
GET /actuator/health → {"groups":["liveness","readiness"],"status":"UP"}
pg_extension: btree_gist 1.7, plpgsql 1.0, timescaledb 2.26.4
```

## Notas
- El primer intento de `docker compose up` falló porque el puerto 5432 ya lo usa un PostgreSQL local (PID 7808). Se cambió el puerto por defecto a 55432.
- Avisos que no bloquean:
  - El `settings.xml` local de Maven declara repositorios privados que devuelven 401 (`flyway-community-db-support`, `red-gate MavenFeed`). No los declara el proyecto.
  - Aviso de JDK 24 por la carga dinámica del agente de Mockito.
