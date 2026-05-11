# Code Verification

## Purpose

Ensure generated code complies with all documented rules, constraints, and interface contracts before marking any generation step as complete.

## Post-Generation Verification (MANDATORY per step)

After generating code for each plan step:
1. Load all reference rule documents listed in project-state.md (or aidlc-state.md for legacy projects)
2. For each generated file, verify:
   - No method violates documented constraints
   - All documented guards are implemented (not commented as TODO)
   - Interface contracts match documented decisions
3. If violations found: fix before marking step complete
4. Log verification result in plan checkbox annotation

## Code Completeness Standard

Generated code MUST be:
- **Compilable**: All imports, types, and method signatures are valid
- **Functional**: Method bodies contain actual implementation logic
- **Complete to contract**: Every interface method has a working implementation

NOT acceptable as "generated code":
- Comment-only method bodies (`// TODO`, `// implement later`)
- Placeholder return statements (`return null;`)
- Partial implementations with inline notes
- Empty method bodies or stub implementations

If implementation requires unavailable information, mark step as PARTIAL — not COMPLETE.

## Decision Traceability Matrix

After generation and before presentation, verify all constraints:

| Decision # | Constraint | Verified In File(s) | Status |
|---|---|---|---|
| D1 | {constraint from rules} | {file path} | ✅ Verified / ❌ Violation |

This matrix is checked after generation and before presentation to user.

## Self-Review Loop (MANDATORY before presentation)

After completing all generation steps for a unit:
1. Re-read generated code (load each file)
2. Check for:
   - Constraint violations against documented rules
   - Interface/implementation inconsistencies
   - Missing error handling required by specs
   - Methods that bypass documented safety constraints
3. Fix issues before presenting to user
4. Note self-corrections in completion summary

## Verification Against Cross-Cutting Rules

When project-state.md or aidlc-state.md lists mandatory reference documents:
1. Load each mandatory document before verification
2. Extract all constraints (MUST, MUST NOT, NEVER, ALWAYS)
3. For each constraint, verify compliance in generated code
4. Document compliance in the decision traceability matrix

## Handling Violations

When a violation is found:
1. DO NOT mark the step as complete
2. Fix the violation in the generated code
3. Re-verify after the fix
4. Log the violation and fix in the unit audit
5. Only then mark the step as [x]

## Handling Partial Implementation

When full implementation is not possible:
1. Mark the step as PARTIAL in the plan (use `[~]` or annotate)
2. Document what is missing and why
3. Create a follow-up item in unit-state.md
4. Inform the user during completion presentation
5. Do NOT present placeholder code as complete
