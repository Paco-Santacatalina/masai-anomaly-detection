---
name: 07-security-review
description: Security review of APIs, PostgreSQL, integrations and AI/agents with severity-rated, evidence-based findings.
---

# Security Review

Check authentication, authorization, validation, injection, secrets, sensitive data, logging, rate limits, file handling, SSRF, path traversal, deserialization, dependencies, privilege escalation and tenant isolation.

For APIs check resource authorization and error leakage.
For PostgreSQL check least privilege, parameterized queries and data isolation.
For integrations check credentials, token scope, TLS, timeouts, retries and leakage.
For AI/agents check prompt injection, indirect injection, excessive agency, unsafe tools, authorization, exfiltration and cross-user context leakage.

Every finding: severity, evidence, impact and recommendation.
