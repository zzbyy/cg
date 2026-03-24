#!/usr/bin/env bash
# install.sh — context-governance installer
# Run once after cloning to ~/context

set -e

CONTEXT_DIR="$(cd "$(dirname "$0")" && pwd)"
COMMANDS_DIR="$HOME/.claude/commands"
CLAUDE_MD="$HOME/.claude/CLAUDE.md"

# Verify we're installed to the right place
if [ "$CONTEXT_DIR" != "$HOME/context" ]; then
    echo "ERROR: This repo must be cloned to ~/context (found: $CONTEXT_DIR)"
    echo "Run: git clone <repo-url> ~/context"
    exit 1
fi

echo ""
echo "Installing context-governance..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 1. Make bin/ scripts executable
chmod +x "$CONTEXT_DIR/bin/"*
echo "  ✓ bin/ scripts executable"
echo "    cg-slug  cg-check-conflicts  cg-inbox-stage  cg-history-append"
echo ""

# 2. Install slash commands to ~/.claude/commands/
mkdir -p "$COMMANDS_DIR"
installed=0
for f in "$CONTEXT_DIR/commands/"*.md; do
    name=$(basename "$f" .md)
    cp "$f" "$COMMANDS_DIR/$(basename "$f")"
    installed=$((installed + 1))
done
echo "  ✓ $installed slash commands installed → $COMMANDS_DIR"
echo "    /cg-setup       first-time guided setup"
echo "    /cg-status      system dashboard"
echo "    /cg-new-project register a new project"
echo "    /cg-checkpoint  save session state for restart"
echo "    /cg-close       run session closure"
echo "    /cg-review      review pending inbox items"
echo "    /cg-archive     archive a project"
echo ""

# 3. Create required empty directories
mkdir -p \
    "$CONTEXT_DIR/inbox" \
    "$CONTEXT_DIR/history" \
    "$CONTEXT_DIR/scratchpad" \
    "$CONTEXT_DIR/projects/_active" \
    "$CONTEXT_DIR/projects/_archived"
echo "  ✓ Directory structure ready"
echo "    inbox/  history/  scratchpad/  projects/_active/  projects/_archived/"
echo ""

# 4. Write context governance instructions to ~/.claude/CLAUDE.md
mkdir -p "$(dirname "$CLAUDE_MD")"
if [ -f "$CLAUDE_MD" ] && grep -q "cg-slug\|context governance\|context-governance" "$CLAUDE_MD" 2>/dev/null; then
    echo "  ✓ ~/.claude/CLAUDE.md already configured"
else
    # Ensure a blank line separator if the file already has content
    if [ -f "$CLAUDE_MD" ] && [ -s "$CLAUDE_MD" ]; then
        echo "" >> "$CLAUDE_MD"
    fi
    cat "$CONTEXT_DIR/docs/claude-md-raw.md" >> "$CLAUDE_MD"
    echo "  ✓ Context governance written to ~/.claude/CLAUDE.md"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "  All done. What to do next:"
echo ""
echo "  1. Open a new Claude Code session in any directory"
echo "  2. Run /cg-setup — Claude walks you through identity,"
echo "     principles, non-negotiables, domains, and first project"
echo "  3. Start working — context loads automatically from then on"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
