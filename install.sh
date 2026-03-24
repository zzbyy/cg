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

# 4. Write context governance instructions to ~/.claude/CLAUDE.md
echo ""
mkdir -p "$(dirname "$CLAUDE_MD")"
if [ -f "$CLAUDE_MD" ] && grep -q "cg-slug\|context governance\|context-governance" "$CLAUDE_MD" 2>/dev/null; then
    echo "✓ ~/.claude/CLAUDE.md already has context governance instructions"
else
    # Ensure a blank line separator if the file already has content
    if [ -f "$CLAUDE_MD" ] && [ -s "$CLAUDE_MD" ]; then
        echo "" >> "$CLAUDE_MD"
    fi
    cat "$CONTEXT_DIR/docs/claude-md-raw.md" >> "$CLAUDE_MD"
    echo "✓ Context governance instructions written to ~/.claude/CLAUDE.md"
fi

echo ""
echo "Done. Open a new Claude Code session and run /cg-setup to get started."
