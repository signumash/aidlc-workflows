# Project Scoping and Multi-Project Support

## Purpose

Enable multiple projects and parallel unit development within the same workspace by introducing project-scoped and unit-scoped state management.

## Project Identification

At workflow start, determine the active project:
1. Check branch name for project identifier
2. Check for existing `aidlc-docs/projects/` directories
3. If multiple projects exist, ask user which project to work on
4. If no projects exist, create one during inception

## Directory Structure

The workspace uses two documentation directories:
- `docs/` — service documentation (system-specs, task-specs) per spec-management principles
- `aidlc-docs/` — AI-DLC workflow management (projects, state, planning artifacts)

### Recommended Structure

```
<WORKSPACE-ROOT>/
├── [application code]
├── docs/                               # Service documentation
│   ├── system-specs/                   # What IS implemented (current truth)
│   │   ├── modules/
│   │   ├── common/
│   │   └── design/
│   └── task-specs/                     # Archived historical task context
│       └── YYYY/MM/TASK-{id}-{name}/
├── aidlc-docs/                         # AI-DLC workflow management
│   └── projects/
│       └── {project-id}/               # {PROJECT_AIDLC_DOCS_ROOT}
│           ├── project-state.md
│           ├── audit.md
│           ├── inception/
│           │   ├── plans/
│           │   ├── reverse-engineering/
│           │   ├── requirements/
│           │   ├── user-stories/
│           │   └── application-design/
│           ├── construction/
│           │   ├── plans/
│           │   ├── {unit-name}/
│           │   │   ├── unit-state.md
│           │   │   ├── audit.md
│           │   │   ├── functional-design/
│           │   │   ├── nfr-requirements/
│           │   │   ├── nfr-design/
│           │   │   ├── infrastructure-design/
│           │   │   └── code/
│           │   └── build-and-test/
│           └── operations/
└── AGENTS.md
```

### Multi-Package Projects

For multi-package projects (typical for deployed services), both `docs/` and `aidlc-docs/` can live in a dedicated documentation package (e.g., `BeerServiceDevDocs/`). This is recommended because cross-cutting features span package boundaries.

## Project-Level State (project-state.md)

Tracks shared project context — inception status, config, unit assignments:

```markdown
# Project: {Project Name}

## Configuration
- **Project ID**: {kebab-case-id}
- **Created**: {ISO date}
- **Lead**: {username}
- **Framework**: {tech stack}
- **Phase**: {INCEPTION/CONSTRUCTION/OPERATIONS}

## Inception Status
- [ ] Workspace Detection
- [ ] Reverse Engineering
- [ ] Requirements Analysis
- [ ] User Stories
- [ ] Application Design
- [ ] Units Generation

## Units Overview
| Unit | Name | Assignee | Status | Branch |
|---|---|---|---|---|
| 0 | Foundation | {user} | Not started | — |

## Shared References
- docs/system-specs/common/{rule}.md — MANDATORY for all units

## Extension Configuration
| Extension | Enabled | Decided At |
|---|---|---|
```

## Unit-Level State (unit-state.md)

Owned by one engineer, no merge conflicts:

```markdown
# Unit {N}: {UnitName}

## Assignment
- **Assignee**: {username}
- **Branch**: {branch-name}
- **Started**: {ISO date}
- **Dependencies**: {list of dependency units and status}

## Progress
- [ ] Functional Design
- [ ] NFR Requirements
- [ ] NFR Design
- [ ] Code Generation
- [ ] Tests
- [ ] System Spec Update

## Context to Load (for session resume)
1. docs/system-specs/common/ (mandatory rules)
2. docs/system-specs/modules/ (relevant modules)
3. docs/system-specs/design/ (architecture)
4. Active unit task spec

## Blocked By
- None

## Blocking
- None
```

## Code Location Rules

- Application code → workspace root (src/, lib/, pkg/, etc.)
- System specs → docs/system-specs/
- Archived task specs → docs/task-specs/YYYY/MM/
- AI-DLC workflow artifacts → aidlc-docs/projects/{project-id}/
- Steering → AGENTS.md or .kiro/steering/

NEVER put application code in docs/ or aidlc-docs/.
NEVER put documentation in the application code directories.

## Naming Conventions

- Project IDs: kebab-case (e.g., `debt-authority-rearchitecture`)
- Unit directories: `unit-{N}-{kebab-case-name}` (e.g., `unit-1-debt-domain`)
- Task spec archives: `TASK-{NNN}-{name}/` (e.g., `TASK-002-debt-domain/`)
- Branch names: `feat/{project-id}-unit-{N}` (e.g., `feat/debt-authority-unit-1`)
