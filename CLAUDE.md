# CLAUDE.md

Proyecto MASAI T3.2 — detección de anomalías energéticas. Monorepo con `svc-energy-rules` (Java), `svc-energy-dl` (Python), `ui` (React) y contratos OpenAPI.

## Cómo se trabaja aquí
- Sigue `.assistant/WORKFLOW.md` y `.assistant/engineering-rules.md`. Las skills están en `.claude/skills/` (00–15).
- Contexto del proyecto: `.assistant/project-context.md`. Arquitectura: `.assistant/architecture/system-overview.md`.
- Cada funcionalidad vive en `.assistant/features/F-XXX-*/` (spec → architecture-options → design → plan → implementation → tests → audit → changelog).
- Decisiones de arquitectura: `.assistant/decisions/ADR-*.md`. Decisiones pendientes: `.assistant/decisions/OPEN-DECISIONS.md`.
- No implementes un bloque sin spec aprobada y ADRs en estado `Accepted`. No inventes reglas de negocio: márcalas como supuesto y añádelas a OPEN-DECISIONS.

## Reglas del dominio que no se negocian
- Todo en UTC. Claves `centro_id`/`propiedad_id` de negocio (no PKs de MESView).
- Las medidas sin contexto productivo se conservan (`normalizable = false`).
- Importaciones idempotentes. Cada cambio de esquema = migración Flyway.
- Los contratos en `contracts/openapi/` son la fuente de verdad entre servicios.

## Referencias
- Funcional: `docs/T3.2_Deteccion_Anomalias_Definicion_Funcional.md`. Plan inicial: `docs/T3.2_Plan_Desarrollo_Inicial.md`.
- `db/mesview/script.sql` es solo el DDL de MESView como referencia; no se ejecuta.
- `research/` es el prototipo ML original; no es código de producto.
