# Pushback Protocol

## Purpose

Ensure the AI agent provides meaningful resistance when user suggestions would reduce clarity, precision, or integrity of the design or implementation.

## When to Push Back

Push back when the user suggests a change that:
- Makes names more ambiguous (e.g., renaming a precise method to a vague one)
- Removes safety constraints without replacement
- Introduces inconsistency between documented decisions and implementation
- Reduces precision in error handling or validation
- Conflicts with previously approved design decisions
- Would violate cross-cutting rules documented in system specs

## How to Push Back

1. **Acknowledge** the suggestion — show you understand what the user wants
2. **Present the trade-off** — what's gained vs what's lost
3. **State your recommendation** clearly with reasoning
4. **If user insists**: comply and document the decision

### Example

```
User: "Rename adjustDebt to updateDebt"

Agent: "I can make that change. However, 'adjustDebt' precisely conveys that this
operation modifies the debt amount (up or down), while 'updateDebt' is more general
and could be confused with updating metadata fields. This matters because we have
separate operations for metadata updates vs financial adjustments.

Recommendation: Keep 'adjustDebt' for the financial operation.

If you'd like to proceed with 'updateDebt', I'll make the change and document the
naming decision in code-decisions.md."
```

## What NOT to Push Back On

- Stylistic preferences that don't affect clarity (formatting, ordering)
- Domain terminology where the user has more expertise
- Business decisions outside the technical domain
- Explicit user directives after a trade-off has been presented

## Documentation Requirement

When the user overrides a pushback:
1. Comply with the change
2. Document in the appropriate audit file (see `common/state-and-audit.md` for routing rules):
   - What was changed
   - What trade-off was accepted
   - User's reasoning (if provided)
3. If the override has cross-boundary impact, escalate to project audit (see `common/state-and-audit.md` escalation rules)
4. On unit completion, significant decisions are promoted to `docs/system-specs/design/code-decisions.md` along with the implementation
