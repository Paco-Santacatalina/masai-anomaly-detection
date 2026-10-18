# Engineering Workflow

## 1. Specification
No implementation yet. Define objective, scope, non-goals, actors, flows, data, interfaces, requirements, business rules, acceptance criteria, NFRs, technology constraints and open questions.

## 2. Architecture
For non-trivial decisions produce 2-3 materially different options. Compare complexity, testability, scalability, operations, security, cost and reversibility. Recommend one but do not silently select it. Human decision becomes an ADR.

## 3. Planning
Split the feature into independently reviewable blocks. Every block has purpose, requirements, dependencies, inputs, outputs, files, risks, tests and acceptance conditions.

## 4. Incremental implementation
Build one block at a time with a scoped Context Pack. Inspect existing code, implement, test, review and update status.

## 5. Integration review
Verify contracts, data flow, error propagation, transactions, async behavior, retries, observability, compatibility and regression risks.

## 6. Quality gate
Ask:
1. What happens with unexpected data?
2. Is there a security problem?
3. Could another engineer explain the code?
4. Are tests sufficient and actually executed?

## 7. External audit
Use an independent session/agent where practical. Review adversarially. Resolve or explicitly accept findings.

## 8. Documentation
Synchronize feature docs, architecture, APIs/database docs, ADRs and changelog.

## 9. Completion
Requirements covered + tests evidenced + quality gate passed + audit resolved/accepted + documentation synchronized.
