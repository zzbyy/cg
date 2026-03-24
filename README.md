# context-governance

> Every Claude Code session starts blank. You re-explain your stack, your decisions, your working style. The AI is capable but amnesiac.

**context-governance** gives Claude a persistent memory across every session. It loads who you are, what you're working on, and what you've already decided — before you type a single word. When the session ends, it proposes what's worth keeping. Nothing is written to permanent memory without your approval.

It's a three-phase loop:

```
Session start   →   do work   →   session end
 (Constructor)                    (Evaluator)
  load context    watch + prompt   stage + commit
```

The Constructor runs automatically at the start of every session. The Evaluator runs when you're done. Between them, Claude watches for decisions and patterns worth keeping and prompts you at the right moment.

This is not a chat history. It's structured memory — identity, principles, project context, decisions, domain knowledge — versioned in git, reviewed by you, owned by you.

---

## Quick start

1. `git clone https://github.com/zzbyy/cg ~/context && cd ~/context && ./install.sh`
2. Add the printed snippet to `~/.claude/CLAUDE.md`
3. Open a new Claude Code session in any project directory
4. Run `/cg-setup` — Claude walks you through populating your identity, preferences, and first project
5. Work. Claude will prompt you when something is worth saving.

---

## Install

**Requirements:** [Claude Code](https://claude.ai/code), Python 3 (stdlib only), git

```bash
git clone https://github.com/zzbyy/cg ~/context
cd ~/context && ./install.sh
```

The installer:
- Makes `bin/` scripts executable
- Copies the `/cg-*` slash commands to `~/.claude/commands/`
- Creates the required directory structure
- Checks your `~/.claude/CLAUDE.md` and prints the snippet to add if it's missing

Then add the printed snippet to `~/.claude/CLAUDE.md` (create the file if it doesn't exist). This tells Claude to load your context at the start of every session.

---

## See it work

```
[New session opens in ~/projects/myapp]

Claude: Loading your context...
        ✓ identity.md — product engineer, fast iteration style
        ✓ principles.md — ship small, test in production
        ✓ non-negotiables.md — 3 rules loaded
        ✓ Project: myapp — last worked on auth flow

        Open checkpoint from yesterday: "mid-way through OAuth refactor"
        Resume from checkpoint? [yes / no]

You:    yes

--- work happens ---

You:    Let's use Postgres for the session store instead of Redis.

Claude: That feels like a decision worth keeping.
        → Replacing Redis with Postgres for session storage
        → Rationale: simpler ops, one fewer service to run
        Stage it? [yes / no / edit]

You:    yes

--- more work ---

You:    ok I'm done for today

Claude: Let me run the closure routine before we finish.

        Decisions this session:
        1. Session store → Postgres (confidence: high) ✓ staged
        2. Auth library: kept Devise over Authlogic (confidence: high)
           Stage it? [yes / no / edit]

        Memory updates:
        → myapp/memory.md: OAuth flow now complete, session store on Postgres
           Write this? [yes / no / edit]

        History log: summary + decisions + outcomes? [yes / summary only / skip]

        Commit message: "session: auth refactor complete, session store decision"
        Confirm commit? [yes / edit / skip]
```

Nothing is written without your approval at each step. The staged items land in `inbox/`, you review them with `/cg-review`, and they're committed to git.

---

## Commands

| Command | Role | What it does |
|---------|------|-------------|
| `/cg-setup` | **Onboarding** | First-time guided setup — populates identity, preferences, non-negotiables |
| `/cg-status` | **Dashboard** | Active projects, inbox count, open checkpoint, uncommitted changes |
| `/cg-new-project` | **Project Manager** | Register a new project — creates context.yaml, memory.md, decisions.md |
| `/cg-checkpoint` | **State Saver** | Write current session state to scratchpad for seamless restart |
| `/cg-close` | **Evaluator** | Run session closure — surface decisions, stage memory updates, commit |
| `/cg-review` | **Inbox Reviewer** | Review and approve pending inbox items, merge into permanent memory |
| `/cg-archive` | **Archivist** | Archive a completed or paused project |

---

## How it works

### The Constructor

Every session starts by loading context in this order:

1. `human/non-negotiables.md` — hard rules that always win
2. `human/preferences.yaml` — your tone, style, tool preferences
3. `global/identity.md` — who you are, how you work
4. `global/principles.md` — your guiding beliefs
5. `registry.yaml` — project index

Then it detects the current project by matching your working directory against the registry, loads that project's `context.yaml`, `memory.md`, and `decisions.md`, checks for an open checkpoint, counts your inbox, and presents a session manifest before starting work.

### The Monitor

During the session, Claude watches for moments worth capturing:

- **Decision made** — a meaningful architectural, strategic, or directional choice
- **Pattern or lesson** — a non-obvious approach that worked or a reusable insight
- **Cross-domain insight** — something from this session that applies to another project
- **Context pressure** — session is getting long; writes a checkpoint automatically
- **Session ending** — task complete, natural pause; initiates closure automatically

It prompts you in the moment, briefly. You say yes, no, or edit. Nothing is staged without your response.

### The Evaluator

At session end, Claude presents a single review block:

1. **Decisions** — every meaningful choice made, with rationale and confidence
2. **Memory updates** — exactly what it plans to write and where
3. **Cross-pollination** — anything worth flagging for another project or domain
4. **History log** — summary, decisions, and outcomes appended to `history/sessions.md`
5. **Scratchpad** — archive or discard the checkpoint
6. **Commit** — proposed message, your confirmation, then `git commit`

---

## The inbox / approval model

Claude never writes to memory files directly. Everything goes through `inbox/` first:

```
session insight
    ↓
inbox/20260324-1430--myapp--chose-postgres--decision.md
    ↓
/cg-review  (you approve, edit, or discard)
    ↓
projects/_active/myapp/decisions.md
    ↓
git commit
```

This means your memory is always intentional. Nothing accumulates without review.

---

## What gets stored

```
~/context/
├── global/
│   ├── identity.md           # Who you are, how you work, current focus
│   ├── principles.md         # Beliefs that guide your work
│   └── cross-pollination.md  # Cross-project insights
├── human/
│   ├── non-negotiables.md    # Hard rules Claude always follows
│   └── preferences.yaml      # Tone, response style, tool preferences
├── projects/_active/{slug}/
│   ├── context.yaml          # Project metadata
│   ├── memory.md             # Accumulated project knowledge
│   ├── decisions.md          # Decision log with rationale
│   └── tasks.md              # Current tasks
├── domains/{name}/
│   └── memory.md             # Domain-specific knowledge (dbt, react, etc.)
├── inbox/                    # Pending items awaiting your approval
├── history/                  # Session history log
└── scratchpad/               # Ephemeral session state (gitignored)
```

`projects/_active/` and `history/sessions.md` are gitignored by default — your personal project data stays local unless you push to a private fork.

---

## Customization

After running `/cg-setup`, the files in `global/` and `human/` are yours. Edit them freely. They're loaded at the start of every session.

You can also create `domains/{name}/memory.md` for domain-specific knowledge (e.g., how your dbt project is structured, your React patterns, your deployment conventions). Add domains to `registry.yaml` to have them loaded automatically.

---

## Project structure

```
~/context/
├── bin/                  # Helper scripts (called by slash commands)
│   ├── cg_lib.py         # Shared library — YAML parser, slug resolution, inbox helpers
│   ├── cg-slug           # Resolve CWD → project slug
│   ├── cg-check-conflicts # Detect open checkpoint / inbox / uncommitted changes
│   ├── cg-inbox-stage    # Write approval-gated items to inbox/
│   └── cg-history-append # Append session entry to history/sessions.md
├── commands/             # Slash command definitions (copied to ~/.claude/commands/)
├── governance/
│   └── templates/        # Scaffold templates for checkpoint.md, manifest.md
├── projects/
│   ├── _template/        # Scaffold for new projects (copied by /cg-new-project)
│   ├── _active/          # Your active projects (gitignored)
│   └── _archived/        # Archived projects (gitignored)
├── domains/              # Domain-specific memory files
├── install.sh            # One-time installer
└── docs/
    └── claude-md-snippet.md  # Snippet to add to ~/.claude/CLAUDE.md
```

---

## Troubleshooting

**Commands not showing up in Claude Code?**
Re-run `cd ~/context && ./install.sh` — it copies the commands to `~/.claude/commands/`.

**Constructor not running at session start?**
Check that `~/.claude/CLAUDE.md` contains the context governance snippet. Run `./install.sh` to print it again.

**`/cg-slug` not resolving your project?**
Make sure the project's `path` in `registry.yaml` matches the actual directory path on disk. The resolver uses longest-prefix-match.

**Want to see what's in your inbox?**
Run `/cg-status` — it shows inbox count and open checkpoint state. Run `/cg-review` to go through pending items.

**Pushed to a private fork and want project data tracked?**
Remove the `projects/_active/*` line from `.gitignore`. Your project files will then be committed with the rest.

---

## Requirements

- [Claude Code](https://claude.ai/code)
- Python 3 (stdlib only — no packages needed)
- git

---

## License

MIT. Free forever.
