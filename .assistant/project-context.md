# Project Context

## Identity
- Project: MASAI — T3.2 Detección de Anomalías Energéticas
- Purpose: detectar pérdidas de eficiencia energética en series temporales de consumo, generar alertas clasificadas y explicadas (reglas + DL no supervisado + fusión híbrida).
- Repository: monorepo local `C:\dev\masai-anomaly-detection` (sin remoto todavía)
- Main branch: `main`
- Leader: EXOS (integración y valor de negocio). CETECK: modelos predictivos.
- Period: M10–M28

## Product
- Primary users: responsable de energía de planta (define reglas, revisa alertas); analista/ingeniero de procesos (confirma/descarta alertas).
- Core problem: identificar consumo energético anómalo respecto al contexto productivo (turno/producto/orden/estado) y explicar su causa probable.
- In scope: ver `docs/T3.2_Deteccion_Anomalias_Definicion_Funcional.md` §2.
- Out of scope: control activo sobre equipos, gemelo digital, mantenimiento predictivo como objetivo propio, sustitución de reglas MES/MOM, IA generativa (§3).

## Stack
### Backend
- Language: Java 21 (target; JDK 24 instalado localmente compila con `--release 21`)
- Framework: Spring Boot 4.1 (ADR-002 revisado), Spring Data JPA/Hibernate 7, Flyway
- Build: Maven (Maven Wrapper; `mvn` no está instalado globalmente)
- Runtime: contenedor Docker
### Database
- PostgreSQL 16 + TimescaleDB 2.26.4 (imagen `timescale/timescaledb:2.26.4-pg16`, esquema propio `t32`, puerto local 55432)
- Migration tool: Flyway
### Frontend
- React + TypeScript
- Build tool: Vite
- State: UNKNOWN (decidir en B3)
- UI: UNKNOWN (decidir en B3)
### AI / ML
- Frameworks: PyTorch, scikit-learn, MLflow
- Service: Python 3.11 + FastAPI (`svc-energy-dl`)
- Model providers: N/A (modelos propios, no LLM)
- Agent framework: N/A
- Evaluation tooling: MLflow; métricas F1/FAR/MAR; SKAB y dataset sintético etiquetado

## Integrations
| System | Purpose | Protocol | Authentication |
|---|---|---|---|
| svc-energy-dl | Scoring DL de ventanas de medidas | REST (OpenAPI `contracts/openapi/svc-energy-dl.yaml`) | UNKNOWN (red interna docker-compose en fase 1) |
| MESView (futuro, B7) | Fuente real de medidas y contexto productivo. Los timestamps están en Europe/Madrid sin zona (D-14) y la clave de centro es `centro.codigo` (D-13) | Fase 1: exportación desde una copia local. B7: sincronización BD→BD (vista o réplica lógica) | UNKNOWN |
| Node-RED (aguas arriba de MESView) | Flujo que escribe las lecturas en la BD de MESView. Determina la frecuencia y la política de muestreo (D-03) | UNKNOWN | UNKNOWN |
| Trazabilidad de incidencias MASAI (futuro) | Envío de alertas confirmadas | UNKNOWN | UNKNOWN |

## Environments
- Local: `infra/docker-compose.yml` (TimescaleDB; servicios añadidos por bloque)
- Test: Testcontainers (imagen TimescaleDB fijada)
- Staging: UNKNOWN
- Production: UNKNOWN (cloud native Docker/Kubernetes previsto por MASAI)

## Repository map
```text
.assistant/          conocimiento y estado del proyecto (skills system v2)
.claude/skills/      skills 00–15 del sistema de ingeniería
contracts/openapi/   contratos API entre servicios (fuente de verdad)
db/mesview/          DDL de referencia de MESView (solo esquema, NO ejecutable)
docs/                documentos funcionales y plan inicial
infra/               docker-compose (B1)
research/            prototipo ML original sobre SKAB (referencia, no producto)
svc-energy-rules/    backend Java (B1+)
svc-energy-dl/       servicio Python DL (B5)
tools/               dataset-builder: SKAB→contrato y generador sintético (B1)
ui/                  React SPA (B3)
```

## Global constraints
- Todas las fechas se almacenan y transportan en UTC.
- `centro_id`/`propiedad_id` son claves de negocio estables, no PKs internas de MESView.
- Medidas sin contexto productivo se conservan y se marcan como no normalizables.
- Operaciones batch idempotentes.
- El motor DL tolera huecos y muestreo irregular.
- Desarrollo desacoplado de MESView hasta la fase de integración (B7).

## Security constraints
- Autenticación/autorización de la API: UNKNOWN (decisión abierta D-08).
- Secretos solo por variables de entorno; `.env` fuera de git.

## Observability
- UNKNOWN (proponer en B2/B4: logs estructurados + correlation id entre servicios).

## Deployment
- Local con docker-compose. Kubernetes fuera de alcance hasta que el proyecto lo requiera.

## Known technical debt
- Prototipo ML (`research/`) con defectos conocidos: ver `.assistant/features/F-005-dl-baseline/README.md`.

## Unknowns
- Ver `.assistant/decisions/OPEN-DECISIONS.md`.
- `db/mesview/script.sql` muestra solo el modelo. Los datos reales están en una tabla de MESView aún no identificada; falta conseguir una copia de la BD (D-02).
