# Spec Management Integration

## Principles

- System specs describe what IS implemented (never what WILL BE)
- Task specs are created in archive location from the start
- System specs updated in the same commit as code changes
- Agents load system specs for context; ignore task spec archives
- Each system spec file: 1,000–5,000 tokens (split if larger)

## Three Content Types

| Content Type | Location | Lifecycle | Owner |
|---|---|---|---|
| System specs | docs/system-specs/ | Updated with every code change | Team |
| Active project work | aidlc-docs/projects/{project}/ | WIP during development | Project lead / engineer |
| Archived task specs | docs/task-specs/YYYY/MM/ | Immutable after archival | Nobody (historical) |

## During AI-DLC Inception Phase

- Architectural decisions → docs/system-specs/design/
- Cross-cutting rules (ledger, security) → docs/system-specs/common/
- Planning artifacts (requirements, stories) → aidlc-docs/projects/{project}/inception/

## During AI-DLC Construction Phase

- Unit task specs (functional design, NFR, code plan) → aidlc-docs/projects/{project}/construction/{unit}/
- Generated code → workspace root (src/)
- After code generation: update docs/system-specs/modules/{component}.md
- After unit complete: verify system specs match implemented behavior

## On Unit Completion

1. Extract implemented behavior from generated code
2. Create/update docs/system-specs/modules/{module}.md (current truth)
3. Archive unit's task-spec to docs/task-specs/YYYY/MM/TASK-{unit}/
4. Remove task-spec from aidlc-docs/projects/ (it's now archived)
5. Update project-state.md (mark unit complete)

## Commit Discipline

- Code changes + system spec updates = same commit
- Task spec archival = same commit as unit completion
- Never commit a system spec describing unimplemented behavior
- Spec updates are reviewed as carefully as code changes

## Context Loading Priority

1. docs/system-specs/common/ (mandatory rules — always load)
2. docs/system-specs/modules/ (relevant to current work only)
3. docs/system-specs/design/ (architectural context)
4. Active unit task spec (only during active construction)
5. Project state (progress tracking)
6. DO NOT load docs/task-specs/ (archived, stale for agents)

## Token Budget

- Each system spec: 1,000–5,000 tokens
- If exceeding 5,000: split by architectural subcomponent (not technical concern)
- Prefer focused loading over comprehensive loading
- Agent quality degrades with irrelevant context even in large windows

## Lifecycle Transitions

```
ACTIVE (being worked on)
    → unit completes
PROMOTED (→ system-specs, describes current implementation)
    +
ARCHIVED (→ task-specs/YYYY/MM/, historical reference only)
```
