# /cg-close — Force Session Closure

Run the full session close protocol from CLAUDE.md.

```bash
eval "$(python3 ~/context/bin/cg-slug)"
python3 ~/context/bin/cg-check-conflicts
```

Present the closure review as a single block:

**1. Decisions** — list meaningful choices made this session with rationale and confidence.
   For each: stage to inbox? [yes / edit / no]
   Use: `python3 ~/context/bin/cg-inbox-stage --type decision ...`

**2. Memory updates** — show exactly what you plan to write and where.
   For each: stage to inbox? [yes / edit / no]
   Use: `python3 ~/context/bin/cg-inbox-stage --type memory ...`

**3. Cross-pollination** — does anything from this session apply to another project/domain?
   If yes: stage cross item? [yes / no]
   Use: `python3 ~/context/bin/cg-inbox-stage --type cross ...`

**4. History log** — ask: "Summary only / summary + decisions + outcomes / skip? Default: middle."
   Use: `python3 ~/context/bin/cg-history-append --project {SLUG} --task "..." --summary "..." ...`

**5. Scratchpad** — checkpoint.md: archive / keep / discard? manifest.md: discard (regenerated).

**6. Commit** — propose message, wait for confirmation, then:
   `cd ~/context && git add -A && git commit -m "{message}"`

After closure: "Session closed. Staged items are in inbox/ — run /cg-review when ready to merge."
