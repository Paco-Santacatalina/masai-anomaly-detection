# MASAI · T3.2 Detección de Anomalías Energéticas

Módulo de detección de pérdidas de eficiencia energética: motor de reglas + modelo DL no supervisado + fusión híbrida, con bandeja de alertas y feedback del usuario. Se desarrolla desacoplado del módulo de monitorización de MESView.

## Estado
Fase 1 en curso. Hecho: B0 (especificación, ADR-001…006 aceptados) y BLK-001 (entorno local y esqueleto del servicio). Siguiente: BLK-002 (esquema del contrato). Ver `.assistant/features/F-001-cimientos-datos/`.

## Estructura
| Ruta | Contenido |
|---|---|
| `.assistant/` | Contexto, arquitectura, ADRs, features y auditorías |
| `.claude/skills/` | Skills del sistema de ingeniería (00–15) |
| `contracts/openapi/` | Contratos API entre servicios |
| `docs/` | Definición funcional y plan inicial |
| `db/mesview/` | DDL de referencia de MESView (no ejecutable) |
| `research/` | Prototipo ML sobre SKAB (referencia) |
| `infra/`, `svc-energy-rules/`, `svc-energy-dl/`, `ui/`, `tools/` | Se crean en B1 y siguientes |

## Requisitos locales
Docker Desktop, JDK 21+, Node 20, Python 3.11 (conda env `deep-learning` o venv).

## Datos SKAB
`research/SKAB/data/` no se versiona. Para obtenerlo: `git clone https://github.com/waico/SKAB` y copiar su carpeta `data/`.

## Arranque local
```bash
cp infra/.env.example infra/.env   # edita T32_DB_PASSWORD
docker compose -f infra/docker-compose.yml --env-file infra/.env up -d
cd svc-energy-rules && ./mvnw verify          # tests con Testcontainers (requiere Docker)
```
Para ejecutar el servicio, exporta las variables de `infra/.env` y lanza `./mvnw spring-boot:run`. También puedes usar `./mvnw spring-boot:test-run`, que levanta una BD efímera con Testcontainers. La BD escucha en `127.0.0.1:55432`.
