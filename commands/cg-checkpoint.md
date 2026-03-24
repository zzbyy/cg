# /cg-checkpoint — Save Session State

**What it does:** Writes a snapshot of the current session to `scratchpad/checkpoint.md`
— what you've done, where you are right now, and the single next step. A new Claude
session can resume exactly from this point with one file read.

**When to run:** When a session is getting long and you want to start fresh without
losing context. When switching to a different task mid-session. When you hear yourself
saying "let me start a new session" — run this first.

Claude also writes checkpoints automatically when sessions run long (~40 messages)
or when you say "checkpoint", "start fresh", or "too long".

---

Run:
```bash
eval "$(python3 ~/context/bin/cg-slug)"
```

Immediately write ~/context/scratchpad/checkpoint.md using the template at
~/context/governance/templates/checkpoint.md. Fill in from the current session:

```
# Checkpoint — {DATE TIME}
## Project / session: {SLUG and task description}
## What we've done: {bullet summary}
## Current state: {exact situation right now}
## Immediate next step: {single next action when resuming}
## Key decisions this session: {not yet in decisions.md}
## Files modified: {list}
## Why checkpointed: {too long / user requested / other}
```

Say: "Checkpoint saved. Start a new session and I'll resume from here with one read.
Run /cg-close first to capture anything worth keeping permanently?"
