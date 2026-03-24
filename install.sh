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

echo "Installing context-governance..."
echo ""

# 1. Make bin/ scripts executable
chmod +x "$CONTEXT_DIR/bin/"*
echo "✓ bin/ scripts executable"

# 2. Install slash commands to ~/.claude/commands/
mkdir -p "$COMMANDS_DIR"
installed=0
for f in "$CONTEXT_DIR/commands/"*.md; do
    name=$(basename "$f")
    cp "$f" "$COMMANDS_DIR/$name"
    installed=$((installed + 1))
done
echo "✓ $installed commands installed to $COMMANDS_DIR"

# 3. Create required empty directories
mkdir -p \
    "$CONTEXT_DIR/inbox" \
    "$CONTEXT_DIR/history" \
    "$CONTEXT_DIR/scratchpad" \
    "$CONTEXT_DIR/projects/_active" \
    "$CONTEXT_DIR/projects/_archived"
echo "✓ directory structure ready"

# 4. Check if CLAUDE.md already has constructor instructions
echo ""
if [ -f "$CLAUDE_MD" ] && grep -q "cg-slug\|context governance\|context-governance" "$CLAUDE_MD" 2>/dev/null; then
    echo "✓ ~/.claude/CLAUDE.md already has context governance instructions"
else
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "MANUAL STEP: Add context governance to your ~/.claude/CLAUDE.md"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    cat "$CONTEXT_DIR/docs/claude-md-snippet.md"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "Copy the block above into ~/.claude/CLAUDE.md"
    echo "(Create the file if it doesn't exist)"
    echo ""
fi

echo "Done. Open a new Claude Code session and run /cg-setup to get started."
