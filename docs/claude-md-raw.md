## Context Governance

You have a persistent context system at ~/context/.
You load from it at session start, watch for insights during the session, and run a
closure routine at the end. You never write to permanent memory without user approval.

### On every session start

Before doing any work, load these files in order:

1. ~/context/human/non-negotiables.md  — always wins, read first
2. ~/context/human/preferences.yaml    — tone, style, tool preferences
3. ~/context/global/identity.md        — who the user is, how they work
4. ~/context/global/principles.md      — guiding beliefs
5. ~/context/registry.yaml             — project index

Then detect the current project:
- Run: eval "$(python3 ~/context/bin/cg-slug)"
- If SLUG is set: load ~/context/projects/_active/{SLUG}/context.yaml,
  memory.md, and decisions.md
- If SLUG=NO_MATCH: ask which project/domain this session is for (or proceed without)

Then check for open state:
- Run: python3 ~/context/bin/cg-check-conflicts
- If CHECKPOINT_OPEN: read ~/context/scratchpad/checkpoint.md, tell the user
- If INBOX_N (N > 0): "You have N pending inbox item(s). Review now or after today's work?"
- If UNCOMMITTED_CHANGES: note it briefly

Write a session manifest to ~/context/scratchpad/manifest.md, present it, and confirm
before starting work.

### During the session — watch for

- **Decision made**: meaningful architectural, strategic, or directional choice.
  Prompt: "That feels like a decision worth keeping. Stage it? [yes / no / edit]"
  If yes: python3 ~/context/bin/cg-inbox-stage --type decision ...

- **Pattern or lesson**: non-obvious approach that worked, reusable insight.
  Prompt: "I noticed a pattern here. Save to domain memory? [yes / no]"

- **Cross-domain insight**: something from this session that applies elsewhere.
  Prompt immediately: "This might connect to your [other domain]. Flag it? [yes / no]"

- **Context pressure** (session ~40 messages, or coherence degrading):
  Write checkpoint. Say: "This session is getting long — checkpoint saved. Keep going or
  start fresh?"

- **Session ending naturally** (task done, user says thanks/done):
  Initiate closure automatically.

- **Recovery phrases** ("restart", "new session", "start fresh", "lost the thread",
  "compact this", "too long", "going in circles", "checkpoint"):
  Write checkpoint instantly.

### Session close — initiate automatically at natural end

Present as a single review block:

1. **Decisions** — list all meaningful choices made, with rationale and confidence.
   Stage approved ones: python3 ~/context/bin/cg-inbox-stage --type decision ...

2. **Memory updates** — show exactly what you plan to write and where.
   Stage approved ones: python3 ~/context/bin/cg-inbox-stage --type memory ...

3. **Cross-pollination** — anything worth flagging for another project/domain?
   Stage if yes: python3 ~/context/bin/cg-inbox-stage --type cross ...

4. **History log** — ask: "Summary only / summary + decisions + outcomes / skip? (default: middle)"
   Append: python3 ~/context/bin/cg-history-append --project {SLUG} --task "..." ...

5. **Scratchpad** — checkpoint.md: archive/keep/discard? manifest.md: discard.

6. **Commit** — propose message, wait for confirmation, then:
   cd ~/context && git add -A && git commit -m "{message}"

### Commands

- /cg-setup       — first-time guided setup
- /cg-status      — show active projects, inbox, open checkpoint
- /cg-new-project — register a new project
- /cg-checkpoint  — force save state for restart
- /cg-close       — force session closure
- /cg-review      — review and merge pending inbox items
- /cg-archive     — archive a completed or paused project

### Hard rules

- Never write to memory files without user approval
- Never commit without explicit confirmation
- Never skip non-negotiables.md — it always wins
- Never load projects/_archived/ unless explicitly asked
- Never let a session end without attempting closure
