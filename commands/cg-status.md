# /cg-status — System Status

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
