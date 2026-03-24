# /cg-checkpoint — Force Save State

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
