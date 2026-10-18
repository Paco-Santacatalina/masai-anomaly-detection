---
name: 00-context-manager
description: Build the minimal Context Pack (feature, block, requirements, ADRs, relevant code/tests, unknowns) before working on any block of a feature.
---

# Context Manager

## Purpose
Construct the smallest sufficient context for a development task.

## Procedure
1. Identify feature and block IDs.
2. Load requirements.
3. Load selected architecture.
4. Load affecting ADRs.
5. Identify upstream/downstream blocks.
6. Select relevant source files and tests.
7. State constraints and unknowns.

## Context Pack
```text
PROJECT
FEATURE
BLOCK
REQUIREMENTS
ARCHITECTURE
ADRs
DEPENDENCIES
RELEVANT CODE
RELEVANT TESTS
CONSTRAINTS
KNOWN UNKNOWNS
```

Do not dump the whole repository into context.
