# State and Audit Management

## Purpose

Define which state and audit files to update at each stage, avoiding merge conflicts in multi-engineer projects and ensuring clear traceability.

## Two Levels of Tracking

### Project Level

**Files**: `{PROJECT_AIDLC_DOCS_ROOT}/project-state.md` and `{PROJECT_AIDLC_DOCS_ROOT}/audit.md`

**Owned by**: Project lead

**Record here**:
- All inception phase activity (requirements, stories, application design, units generation)
- Unit assignments, completions, and status transitions
- Cross-unit interface changes or negotiations
- Application design modifications (post-inception)
- Requirement changes or scope adjustments
- Extension configuration decisions
- Build-and-test results (spans all units)
- Workflow changes (stage additions, skips, restarts)

### Unit Level

**Files**: `{PROJECT_AIDLC_DOCS_ROOT}/construction/{unit-name}/unit-state.md` and `{PROJECT_AIDLC_DOCS_ROOT}/construction/{unit-name}/audit.md`

**Owned by**: Assigned engineer

**Record here**:
- Functional design decisions and approvals for this unit
- NFR requirements and design decisions for this unit
- Code generation progress, step completions, and approvals
- Verification violations and fixes
- Pushback overrides during unit construction
- Any unit-scoped error recovery

## Routing Rules

### During Inception Phase

All logging goes to **project-level** (`{PROJECT_AIDLC_DOCS_ROOT}/audit.md`):
- This is shared team work — one session, no parallel engineers

### During Construction Phase (per-unit stages)

All logging goes to **unit-level** (`{PROJECT_AIDLC_DOCS_ROOT}/construction/{unit-name}/audit.md`):
- Functional Design approvals
- NFR Requirements approvals
- NFR Design approvals
- Infrastructure Design approvals
- Code Generation plan approvals, step completions, verification results
- Each engineer writes only to their own unit's audit

### During Build and Test (post all units)

Logging goes to **project-level** (`{PROJECT_AIDLC_DOCS_ROOT}/audit.md`):
- Build-and-test spans all units and is a project-level activity

## Escalation: Unit Change with Cross-Boundary Impact

When a unit-level change impacts another unit or the overall design:

1. Log the change in the **unit audit** (what was changed and why)
2. ALSO log in the **project audit** with tag `[ESCALATION]`:
   - What unit triggered the change
   - What cross-boundary impact was identified
   - What other units or designs are affected
3. Flag for project lead review
4. Do NOT proceed with cross-boundary changes without project lead approval

**Examples of escalation triggers**:
- A unit's functional design reveals a needed change to application-design component boundaries
- A unit's interface needs to change in a way that affects a dependent unit
- A requirement gap is discovered during construction that affects multiple units
- A pushback override changes a cross-cutting rule

## State Update Rules

### project-state.md Updates

Update project-state.md when:
- An inception stage completes (mark checkbox)
- A unit's status changes (update Units Overview table)
- Extension configuration changes
- Phase transitions (INCEPTION → CONSTRUCTION → OPERATIONS)

### unit-state.md Updates

Update unit-state.md when:
- A construction sub-stage completes for this unit (mark checkbox)
- Unit becomes blocked or unblocked
- Dependencies change
- Unit reaches COMPLETE status

## Audit Format (both levels)

```markdown
## [Stage Name]
**Timestamp**: [ISO 8601]
**User Input**: "[Complete raw user input — never summarized]"
**AI Response**: "[AI's response or action taken]"
**Context**: [Stage, action, or decision made]

---
```

## Audit File Rules

- Append-only — NEVER overwrite existing content
- NEVER summarize or paraphrase user input
- Include ISO 8601 timestamps for every entry
- Log every interaction, not just approvals
