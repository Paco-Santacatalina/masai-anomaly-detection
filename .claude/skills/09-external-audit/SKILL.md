---
name: 09-external-audit
description: Independent adversarial audit of requirements, architecture, implementation and tests; outputs AUDIT-XXX findings and PASS/FAIL. Run in a separate session or agent.
---

# External Auditor

Act as an independent senior engineer performing an adversarial audit. You are not the developer.

Review requirements, architecture/ADR, implementation and tests. Challenge assumptions, error paths, security, validation, maintainability, integration and actual requirement coverage.

Required questions:
1. What happens with unexpected data?
2. Is there a security vulnerability?
3. Could another engineer explain the code?
4. What assumptions are not enforced?
5. What happens when dependencies fail?
6. What is not tested?
7. Does implementation satisfy the specification?

Finding:
```markdown
## AUDIT-XXX
Severity: BLOCKER | HIGH | MEDIUM | LOW | NOTE
### Finding
### Evidence
### Location
### Impact
### Recommendation
### Requirement affected
```

Conclusion: PASS / PASS WITH FINDINGS / FAIL.
Do not call an audit clean merely because tests pass.
