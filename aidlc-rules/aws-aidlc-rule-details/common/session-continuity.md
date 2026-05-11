# Session Continuity Templates

## Welcome Back Prompt Template
When a user returns to continue work on an existing AI-DLC project, present this prompt:

```markdown
**Welcome back! I can see you have an existing AI-DLC project in progress.**

Based on your project-state.md, here's your current status:
- **Project**: [project-name]
- **Current Phase**: [INCEPTION/CONSTRUCTION/OPERATIONS]
- **Current Stage**: [Stage Name]
- **Last Completed**: [Last completed step]
- **Next Step**: [Next step to work on]

**What would you like to work on today?**

A) Continue where you left off ([Next step description])
B) Review a previous stage ([Show available stages])

[Answer]: 
```

## MANDATORY: Session Continuity Instructions
1. **Always read project-state.md first** when detecting existing project
2. **Parse current status** from the workflow file to populate the prompt
3. **MANDATORY: Load Previous Stage Artifacts** - Before resuming any stage, automatically read all relevant artifacts from previous stages:
   - **Reverse Engineering**: Read architecture.md, code-structure.md, api-documentation.md
   - **Requirements Analysis**: Read requirements.md, requirement-verification-questions.md
   - **User Stories**: Read stories.md, personas.md, story-generation-plan.md
   - **Application Design**: Read application-design artifacts (components.md, component-methods.md, services.md)
   - **Design (Units)**: Read unit-of-work.md, unit-of-work-dependency.md, unit-of-work-story-map.md
   - **Per-Unit Design**: Read functional-design.md, nfr-requirements.md, nfr-design.md, infrastructure-design.md
   - **Code Stages**: Read all code files, plans, AND all previous artifacts
4. **Smart Context Loading by Stage**:
   - **Early Stages (Workspace Detection, Reverse Engineering)**: Load workspace analysis
   - **Requirements/Stories**: Load reverse engineering + requirements artifacts
   - **Design Stages**: Load requirements + stories + architecture + design artifacts
   - **Code Stages**: Load ALL artifacts + existing code files
5. **Adapt options** based on architectural choice and current phase
6. **Show specific next steps** rather than generic descriptions
7. **Log the continuity prompt** in audit.md with timestamp
8. **Context Summary**: After loading artifacts, provide brief summary of what was loaded for user awareness
9. **Asking questions**: ALWAYS ask clarification or user feedback questions by placing them in .md files. DO NOT place the multiple-choice questions in-line in the chat session.

## Multi-Project/Unit Session Resume Protocol

When the workspace uses project-scoped state (`aidlc-docs/projects/`), use this scoped loading approach:

### Step 1: Identify Active Context
- Which PROJECT? (check branch name or ask)
- Which UNIT? (check branch or ask)

### Step 2: Load Scoped Context (in order)
1. `aidlc-docs/projects/{project}/project-state.md`
2. `aidlc-docs/projects/{project}/construction/{unit}/unit-state.md`
3. `docs/system-specs/common/*` (mandatory rules)
4. `docs/system-specs/modules/*` (relevant only)
5. `docs/system-specs/design/*`
6. Unit task-spec from `aidlc-docs/projects/{project}/construction/{unit}/` (if in construction)

### Step 3: Present Scoped Status
- Project name and phase
- Current unit and progress
- Last completed step
- Dependencies status
- Next action

### DO NOT Load:
- Other projects' state
- Other units' state (unless checking dependency)
- Archived task specs (docs/task-specs/)
- Completed inception artifacts (unless referenced)

## Error Handling
If artifacts are missing or corrupted during session resumption, see [error-handling.md](error-handling.md) for guidance on recovery procedures.
