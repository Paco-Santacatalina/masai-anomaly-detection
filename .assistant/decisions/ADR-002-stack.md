# ADR-002 — Stack tecnológico y organización del repositorio
Status: Accepted (revisado 2026-10-16: Spring Boot 4.1)
Date: 2026-10-14

## Context
El funcional (§7) propone Java/Hibernate, Python/FastAPI y TimescaleDB, y deja la UI "a definir". El plan inicial (§5) exige cerrar el stack concreto del backend y el mecanismo de UI antes de B1/B2.

## Decision
- **Backend `svc-energy-rules`:** Java 21 (LTS), **Spring Boot 4.1.x** (originalmente se decidió Spring Boot 3; ver la revisión del 2026-10-16), Spring Data JPA/Hibernate 7, Flyway y Maven (con wrapper). Tests con JUnit 5 y Testcontainers. API contract-first: interfaces generadas desde `contracts/openapi/` con openapi-generator. Los errores siguen RFC 7807 (`ProblemDetail`).
- **DL `svc-energy-dl`:** Python 3.11, FastAPI, PyTorch, scikit-learn y MLflow.
- **Base de datos:** PostgreSQL 16 + TimescaleDB 2.x, con la imagen fijada a una versión concreta, en un esquema propio `t32`.
- **UI:** SPA en React + TypeScript + Vite, que consume la API REST del backend. La librería de componentes y la gestión de estado se deciden en B3.
- **Repositorio:** monorepo único con `.assistant/` y `.claude/skills/` en la raíz. Vive fuera de OneDrive, en `C:\dev\masai-anomaly-detection`.

## Alternatives
- Quarkus: arranque y memoria menores, pero menos familiar para el equipo.
- Jakarta EE / JSF como MESView: facilita embeber la UI más adelante, pero es pesado para un microservicio.
- UI con Thymeleaf en el servidor: menos piezas, pero más difícil de embeber y de evolucionar.
- Un repositorio por servicio: más coordinación del contrato.

## Why this decision
Spring Boot es el ecosistema Java más estándar y es compatible con el Hibernate que ya usa MESView. React encaja con la skill 14 y puede embeberse después (iframe o micro-frontend). El monorepo mantiene contrato, servicios y documentación versionados juntos.

## Consequences
### Positive
- Tooling estándar y un único punto de verdad para el contrato.
- Los tests de integración usan una base de datos real gracias a Testcontainers.
### Negative
- La UI de MESView es JSF/PrimeFaces, así que embeber la SPA en B7 requiere iframe o micro-frontend.
- En local hay JDK 24 instalado, pero se compila con `--release 21`.

## Revisión 2026-10-16 — de Spring Boot 3 a 4.1
Al empezar BLK-001 se comprobó que Spring Initializr ya no ofrece Spring Boot 3. La 3.5 había dejado de recibir soporte gratuito, y las versiones GA disponibles eran la 4.0.8 y la 4.1.1. EXOS eligió la **4.1.x** porque es la que tendrá soporte más tiempo. Consecuencias:
- Jakarta EE 11, Hibernate 7 y Jackson 3.
- Starters más modulares, por ejemplo `spring-boot-starter-flyway` y `spring-boot-starter-webmvc`.
- Testcontainers 2 (`org.testcontainers.postgresql.PostgreSQLContainer`).
- Java 21 sigue siendo válido.

## Related features
Todas.
