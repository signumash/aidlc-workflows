# Workspace Detection

**Purpose**: Determine workspace state and check for existing AI-DLC projects

## Step 1: Check for Existing AI-DLC Project

Check for existing project state:

1. Check if `aidlc-docs/aidlc-state.md` exists
   - **If exists**: check `aidlc-docs/projects/` for active projects
   - If multiple active projects: ask user which to resume
   - Load the selected project's `project-state.md`
   - Resume from last phase (load context from previous phases)
2. Check if `docs/system-specs/` exists (spec-managed service documentation)
   - If found: load `AGENTS.md` for context configuration and system specs for current state

**If no existing project state found:**
- Continue with new project assessment

## Step 2: Scan Workspace for Existing Code

**Determine if workspace has existing code:**
- Scan workspace for source code files (.java, .py, .js, .ts, .jsx, .tsx, .kt, .kts, .scala, .groovy, .go, .rs, .rb, .php, .c, .h, .cpp, .hpp, .cc, .cs, .fs, etc.)
- Check for build files (pom.xml, package.json, build.gradle, etc.)
- Look for project structure indicators
- Identify workspace root directory (NOT aidlc-docs/)

**Record findings:**
```markdown
## Workspace State
- **Existing Code**: [Yes/No]
- **Programming Languages**: [List if found]
- **Build System**: [Maven/Gradle/npm/etc. if found]
- **Project Structure**: [Monolith/Microservices/Library/Empty]
- **Workspace Root**: [Absolute path]
```

## Step 3: Determine Next Phase

**IF workspace is empty (no existing code)**:
- Set flag: `brownfield = false`
- Next phase: Requirements Analysis

**IF workspace has existing code**:
- Set flag: `brownfield = true`
- Check for existing reverse engineering artifacts in `{PROJECT_AIDLC_DOCS_ROOT}/inception/reverse-engineering/`
- **IF reverse engineering artifacts exist**:
    - Check if artifacts are stale (compare artifact timestamps against codebase's last significant modification)
    - **IF artifacts are current**: Load them, skip to Requirements Analysis
    - **IF artifacts are stale**: Next phase is Reverse Engineering (rerun to refresh artifacts)
    - **IF user explicitly requests rerun**: Next phase is Reverse Engineering regardless of staleness
- **IF no reverse engineering artifacts**: Next phase is Reverse Engineering

## Step 4: Create Initial State File

Create `aidlc-docs/projects/{project-id}/` directory and `{PROJECT_AIDLC_DOCS_ROOT}/project-state.md`:

```markdown
# Project: [Project Name]

## Configuration
- **Project ID**: [kebab-case-id]
- **Created**: [ISO timestamp]
- **Lead**: [username]
- **Framework**: [tech stack]
- **Phase**: INCEPTION
- **Project Type**: [Greenfield/Brownfield]
- **Workspace Root**: [Absolute path]
- **Existing Code**: [Yes/No]
- **Reverse Engineering Needed**: [Yes/No]

## Inception Status
- [x] Workspace Detection
- [ ] Reverse Engineering
- [ ] Requirements Analysis
- [ ] User Stories
- [ ] Application Design
- [ ] Units Generation

## Units Overview
| Unit | Name | Assignee | Status | Branch |
|---|---|---|---|---|

## Shared References
- docs/system-specs/common/ — MANDATORY for all units

## Extension Configuration
| Extension | Enabled | Decided At |
|---|---|---|
```

## Step 5: Present Completion Message

**For Brownfield Projects:**
```markdown
# 🔍 Workspace Detection Complete

Workspace analysis findings:
• **Project Type**: Brownfield project
• [AI-generated summary of workspace findings in bullet points]
• **Next Step**: Proceeding to **Reverse Engineering** to analyze existing codebase...
```

**For Greenfield Projects:**
```markdown
# 🔍 Workspace Detection Complete

Workspace analysis findings:
• **Project Type**: Greenfield project
• **Next Step**: Proceeding to **Requirements Analysis**...
```

## Step 6: Automatically Proceed

- **No user approval required** - this is informational only
- Automatically proceed to next phase:
  - **Brownfield**: Reverse Engineering (if no existing artifacts) or Requirements Analysis (if artifacts exist)
  - **Greenfield**: Requirements Analysis
