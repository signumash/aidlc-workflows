# Unit Completion

## Purpose

Define the process for completing a unit of work: promoting implemented behavior to system specs, archiving task specs, and updating project state.

## Prerequisites

- All code generation steps marked complete
- All tests passing (or documented as expected failures)
- Code reviewed and approved
- System spec updates drafted

## Step 1: Verify Implementation Completeness

- [ ] All plan steps marked [x] in code generation plan
- [ ] All unit stories implemented
- [ ] No TODO/placeholder comments in generated code
- [ ] Code compiles and passes tests

## Step 2: Promote to System Specs

Extract implemented behavior and update system specs:

- [ ] Create/update docs/system-specs/modules/{module}.md with:
  - Current API surface (methods, parameters, return types)
  - Current state machine (if applicable)
  - Current business rules as implemented
  - Current data model
- [ ] Update docs/system-specs/common/ if cross-cutting rules were refined
- [ ] Update docs/system-specs/design/code-decisions.md if new decisions were made

### System Spec Content Rules

System specs describe what IS (present tense):
- "The service exposes..." (not "The service will expose...")
- "Validation rejects..." (not "Validation should reject...")
- "The state machine transitions..." (not "The state machine will transition...")

## Step 3: Archive Task Spec

- [ ] Copy unit task spec to docs/task-specs/YYYY/MM/TASK-{NNN}-{unit-name}/spec.md
- [ ] Remove task-spec from aidlc-docs/projects/{project}/construction/{unit}/
- [ ] Verify archived spec matches what was implemented (not what was planned)

## Step 4: Update Project State

- [ ] Mark unit as COMPLETE in project-state.md units table
- [ ] Update unit-state.md status to COMPLETE
- [ ] Check if any blocked units can now proceed
- [ ] Note completion date in unit-state.md

## Step 5: Commit Discipline

All of the following go in the same commit (or CR):
- System spec updates (docs/system-specs/)
- Task spec archival (docs/task-specs/)
- Task spec removal from active project (aidlc-docs/projects/)
- Project state update (project-state.md)

## Step 6: Notify Dependencies

- [ ] Check project-state.md for units that depend on this unit
- [ ] If dependent units exist, note they are now unblocked
- [ ] Present status to user

## Completion Criteria

- System specs reflect implemented behavior (not planned behavior)
- Task spec is archived and removed from active project
- Project state shows unit as complete
- All changes in single commit/CR
- No stale references to the unit's task spec remain in active docs
