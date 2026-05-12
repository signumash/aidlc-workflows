#!/bin/bash
# Install AI-DLC rules from the latest release
# Usage: ./install-aidlc-rules.sh <tool>
# Tools: kiro, amazonq, cursor, cline, claude, copilot, codex
#
# Fetches the latest release (including pre-releases) from GitHub,
# downloads the zip, and installs rules into the correct location
# for the specified coding agent.

set -euo pipefail

REPO="signumash/aidlc-workflows"
TOOL="${1:-}"

if [ -z "$TOOL" ]; then
    echo "Usage: $0 <tool>"
    echo ""
    echo "Supported tools:"
    echo "  kiro      - Kiro IDE / CLI (.kiro/steering/)"
    echo "  amazonq   - Amazon Q Developer (.amazonq/rules/)"
    echo "  cursor    - Cursor IDE (.cursor/rules/)"
    echo "  cline     - Cline (.clinerules/)"
    echo "  claude    - Claude Code (CLAUDE.md)"
    echo "  copilot   - GitHub Copilot (.github/copilot-instructions.md)"
    echo "  codex     - OpenAI Codex (AGENTS.md)"
    exit 1
fi

# Fetch latest release tag (including pre-releases)
echo "Fetching latest release from $REPO..."
LATEST_TAG=$(curl -s "https://api.github.com/repos/$REPO/releases" | grep -m1 '"tag_name"' | cut -d'"' -f4)

if [ -z "$LATEST_TAG" ]; then
    echo "ERROR: Could not determine latest release"
    exit 1
fi

echo "Latest release: $LATEST_TAG"

# Download
DOWNLOAD_URL="https://github.com/$REPO/releases/download/$LATEST_TAG/ai-dlc-rules-${LATEST_TAG}.zip"
echo "Downloading..."
curl -sL "$DOWNLOAD_URL" -o /tmp/ai-dlc-rules.zip

if [ ! -s /tmp/ai-dlc-rules.zip ]; then
    echo "ERROR: Download failed"
    rm -f /tmp/ai-dlc-rules.zip
    exit 1
fi

# Extract to temp
rm -rf /tmp/aidlc-rules-extract
mkdir -p /tmp/aidlc-rules-extract
unzip -qo /tmp/ai-dlc-rules.zip -d /tmp/aidlc-rules-extract
rm /tmp/ai-dlc-rules.zip

RULES="/tmp/aidlc-rules-extract/aidlc-rules"

# Install based on tool
case "$TOOL" in
    kiro)
        mkdir -p .kiro/steering
        cp -R "$RULES/aws-aidlc-rules" .kiro/steering/
        cp -R "$RULES/aws-aidlc-rule-details" .kiro/
        echo "Installed to .kiro/steering/ and .kiro/aws-aidlc-rule-details/"
        ;;
    amazonq)
        mkdir -p .amazonq/rules
        cp -R "$RULES/aws-aidlc-rules" .amazonq/rules/
        cp -R "$RULES/aws-aidlc-rule-details" .amazonq/
        echo "Installed to .amazonq/rules/ and .amazonq/aws-aidlc-rule-details/"
        ;;
    cursor)
        mkdir -p .cursor/rules
        cat > .cursor/rules/ai-dlc-workflow.mdc << 'EOF'
---
description: "AI-DLC (AI-Driven Development Life Cycle) adaptive workflow for software development"
alwaysApply: true
---

EOF
        cat "$RULES/aws-aidlc-rules/core-workflow.md" >> .cursor/rules/ai-dlc-workflow.mdc
        mkdir -p .aidlc-rule-details
        cp -R "$RULES/aws-aidlc-rule-details/"* .aidlc-rule-details/
        echo "Installed to .cursor/rules/ and .aidlc-rule-details/"
        ;;
    cline)
        mkdir -p .clinerules
        cp "$RULES/aws-aidlc-rules/core-workflow.md" .clinerules/
        mkdir -p .aidlc-rule-details
        cp -R "$RULES/aws-aidlc-rule-details/"* .aidlc-rule-details/
        echo "Installed to .clinerules/ and .aidlc-rule-details/"
        ;;
    claude)
        cp "$RULES/aws-aidlc-rules/core-workflow.md" ./CLAUDE.md
        mkdir -p .aidlc-rule-details
        cp -R "$RULES/aws-aidlc-rule-details/"* .aidlc-rule-details/
        echo "Installed to CLAUDE.md and .aidlc-rule-details/"
        ;;
    copilot)
        mkdir -p .github
        cp "$RULES/aws-aidlc-rules/core-workflow.md" .github/copilot-instructions.md
        mkdir -p .aidlc-rule-details
        cp -R "$RULES/aws-aidlc-rule-details/"* .aidlc-rule-details/
        echo "Installed to .github/copilot-instructions.md and .aidlc-rule-details/"
        ;;
    codex)
        cp "$RULES/aws-aidlc-rules/core-workflow.md" ./AGENTS.md
        mkdir -p .aidlc-rule-details
        cp -R "$RULES/aws-aidlc-rule-details/"* .aidlc-rule-details/
        echo "Installed to AGENTS.md and .aidlc-rule-details/"
        ;;
    *)
        echo "ERROR: Unknown tool '$TOOL'"
        echo "Supported: kiro, amazonq, cursor, cline, claude, copilot, codex"
        rm -rf /tmp/aidlc-rules-extract
        exit 1
        ;;
esac

rm -rf /tmp/aidlc-rules-extract
echo "Done. AI-DLC rules $LATEST_TAG installed for $TOOL."
