# ADR-001 — Dos servicios independientes con MVP vertical y adaptador DL falso
Status: Accepted
Date: 2026-10-14

## Context
El funcional (§8) decide estructurar T3.2 como dos servicios: backend Java (reglas, fusión, alertas, persistencia, UI) y microservicio Python/FastAPI (entrenamiento y scoring DL), comunicados por REST con contrato OpenAPI. El plan inicial (§3) compara tres opciones:
- A: dos servicios desde el inicio.
- B: monolito Python para el MVP.
- C: Java con entrenamiento Python offline, sin endpoint.

Recomienda A implementada como MVP vertical.

## Decision
Opción A. Se construye primero `svc-energy-rules` con reglas y un adaptador DL falso que cumple el contrato `svc-energy-dl.yaml`. En B5 el adaptador falso se sustituye por el servicio real sin cambiar el contrato.

## Alternatives
- B. Monolito Python: menor complejidad inicial, pero retrasa la frontera Java/Python acordada entre EXOS y CETECK y encarece la migración.
- C. Entrenamiento offline sin endpoint: operación sencilla, pero no valida a tiempo el contrato entre servicios ni el scoring near-real-time.

## Why this decision
- Pipeline MLOps independiente del backend.
- Frontera técnica que coincide con el reparto EXOS/CETECK.
- Alineado con la orientación cloud native de MASAI.
- El adaptador falso evita que el modelo bloquee la entrega temprana de reglas y alertas.

## Consequences
### Positive
- Cada servicio se despliega y versiona por separado.
- Los equipos trabajan en paralelo contra el OpenAPI.
- Hay un modo degradado solo-reglas explícito.
### Negative
- Dos runtimes, dos pipelines CI y versionado de API.
- Más coste de arranque para un equipo pequeño, mitigado con docker-compose.

## Related features
F-001, F-004 (adaptador DL), F-005 (DL baseline)
