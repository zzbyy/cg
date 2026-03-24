# /cg-status — System Dashboard

**What it does:** Shows the current state of your context system — active projects,
inbox count, open checkpoint, and whether Claude detected a project match for your
current directory.

**When to run:** Any time you want a quick orientation. Useful at the start of a
session, when you're unsure what's loaded, or when you want to check pending inbox items.

---

Run:
```bash
eval "$(python3 ~/context/bin/cg-slug)"
python3 ~/context/bin/cg-check-conflicts
```

Read ~/context/registry.yaml and all context.yaml files in projects/_active/.

Display a dashboard:

```
CONTEXT GOVERNANCE STATUS
=========================
System: v{version} | Initiated: {initiated_at}

Active Projects ({N}):
  {slug}: {name} — {path}

Domains: {list}

Inbox: {N} pending items  ← offer /cg-review if N > 0
Checkpoint: {OPEN / clear}  ← offer to read if open
Current session: {SLUG or "no project match for current directory"}
=========================
```

If there are inbox items, ask: "Review them now or later?"
If a checkpoint is open, ask: "Resume from checkpoint or start fresh?"
