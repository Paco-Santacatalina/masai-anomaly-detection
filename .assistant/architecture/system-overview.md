# System Architecture

> Estado: objetivo (target). Solo existe lo marcado como implementado en cada feature (`.assistant/features/*/implementation.md`).

## Overview
Dos servicios independientes (ADR-001) sobre una instancia TimescaleDB propia, orquestados localmente con docker-compose.

## Diagram
```text
                 [React SPA  (ui/)]                         B3
                        |
                        v  REST /api/v1  (contracts/openapi/svc-energy-rules.yaml)
   +--------------------------------------------------+
   | svc-energy-rules  (Java 21 / Spring Boot 3)       |
   |  catalog | measurement | ingest            (B1)   |
   |  rules (versionadas, evaluación programada) (B2)  |
   |  alerts (bandeja, estados, feedback)        (B3)  |
   |  dlclient (adaptador; fake hasta B5)        (B4)  |
   |  fusion (política híbrida, prioridad)       (B6)  |
   +-----------+------------------------+-------------+
               |  JDBC / Flyway         |  REST /v1/score (svc-energy-dl.yaml)
               v                        v
   [TimescaleDB · esquema t32]   [svc-energy-dl (Python / FastAPI)]   B5
    medida_energia (hypertable)    training job · model registry (MLflow, B7)
    contexto_produccion            scoring · drift (B7)
    agregados continuos                  |
               ^                         | lectura de features (SQL, solo lectura)
               +-------------------------+
   [CSV dataset (tools/dataset-builder)] --import--> svc-energy-rules      B1
   [MESView] --sync job (B7)--> t32
```

## Components
| Componente | Responsabilidad | Bloque |
|---|---|---|
| `svc-energy-rules` | Persistencia del contrato, ingesta, reglas, alertas, fusión, API y backend de la UI | B1–B4, B6 |
| `svc-energy-dl` | Entrenamiento, registro de modelos, scoring REST, drift | B5, B7 |
| `ui` | Bandeja de alertas y editor de reglas | B3 |
| `tools/dataset-builder` | SKAB → CSV de contrato; generador sintético de planta con anomalías etiquetadas | B1 |
| TimescaleDB `t32` | Contrato de datos (§6 funcional) y agregados | B1 |

## Data ownership
- `svc-energy-rules` es propietario del esquema `t32` y de sus migraciones (Flyway).
- `svc-energy-dl` lee medidas (usuario de BD de solo lectura, a definir en B5) y es propietario de sus artefactos de modelo.

## Integrations
Ver `.assistant/project-context.md` → Integrations.

## Trust boundaries
- UI ↔ svc-energy-rules: usuario final (autenticación: decisión abierta D-08).
- svc-energy-rules ↔ svc-energy-dl: red interna; timeout, validación de esquema y modo degradado solo-reglas (B4).
- Ficheros de importación: entrada no confiable (validación estricta, límites de tamaño).

## Deployment
docker-compose local (`infra/`). Kubernetes fuera de alcance por ahora.

## Observability
Por definir (D-11).

## Current constraints
Ver `.assistant/project-context.md` → Global constraints.

## Known technical debt
Ver F-005.
