# Unit Assignment and Dependency Management

## Purpose

Coordinate parallel unit development across multiple engineers with clear dependency tracking and interface contracts.

## Starting a Dependent Unit

Before starting a unit that depends on another:
1. Check dependency unit's unit-state.md — is it COMPLETE?
2. Check if dependency code is merged to agreed branch
3. If not complete: can start functional design but not construction
4. If complete: load dependency's system spec and proceed

## Cross-Unit Interface Resolution

Cross-unit dependencies are resolved during planning, not by pre-populating system specs:

1. **Units Generation (inception)** — identify cross-unit dependencies and high-level interface contracts
2. **Unit 0 / Foundation (construction)** — implement shared interfaces, models, and contracts that other units depend on
3. **Functional Design (per unit)** — define that unit's side of cross-unit boundaries in detail
4. **Unit Completion** — only then do implemented interfaces land in `docs/system-specs/` via normal promotion

Cross-unit interfaces MUST NOT be written to `docs/system-specs/` before they are implemented. The planning artifacts in `aidlc-docs/` (application-design, functional-design) serve as the contract during development.

## Merge Order

Units merge in dependency order:
1. Foundation units merge first (no dependencies)
2. Dependent units merge after their dependencies
3. Independent units can merge in any order relative to each other

## Assignment Rules

- Each unit-state.md is owned by exactly one engineer
- Only the assigned engineer updates their unit-state.md
- Project lead updates project-state.md when units complete or assignments change
- No merge conflicts possible when each engineer works in their own unit directory

## Dependency Checking Protocol

When resuming work on a unit:
1. Read own unit-state.md for current progress
2. Check "Dependencies" field
3. For each dependency:
   - Read dependency unit's unit-state.md
   - If dependency is COMPLETE: proceed normally
   - If dependency is IN PROGRESS: can do design work but not code that requires the dependency
   - If dependency is BLOCKED: flag to user and suggest alternative work

## Status Transitions

```
NOT STARTED → IN PROGRESS (when first step begins)
IN PROGRESS → BLOCKED (when dependency is unavailable)
BLOCKED → IN PROGRESS (when blocker resolves)
IN PROGRESS → COMPLETE (when all steps done + system spec updated)
```

## Notification Protocol

When a unit completes:
1. Update own unit-state.md to COMPLETE
2. Project lead updates project-state.md
3. Any units listing this as a dependency can now proceed to construction
