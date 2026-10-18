---
name: 13-backend
description: Backend checklist for APIs, PostgreSQL/TimescaleDB and external API adapters (validation, error model, idempotency, migrations, timeouts).
---

# Backend

## APIs
Check validation, authentication, authorization, error model, idempotency, pagination/filtering, versioning, compatibility, observability and timeouts.

## PostgreSQL
Check migrations, constraints, indexes, transactions, locking, query performance, integrity and rollback.

## External APIs
Use adapter/client boundaries. Define authentication, timeout, retries, rate limits, idempotency, schema validation, mappings and failure behavior.

Controllers should orchestrate, not contain business logic.
