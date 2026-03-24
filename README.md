# context-governance

Persistent session memory for [Claude Code](https://claude.ai/code). Gives Claude a continuous understanding of who you are, what you're working on, and what matters — across every session.

## The problem

Every Claude Code session starts blank. You re-explain your working style, your project context, what decisions you've already made. The AI is capable but amnesiac.

## How it works

```
Session start  →  load your context  →  do work  →  watch for insights  →  session end  →  review & commit
  (constructor)     (identity, projects)   (you work)   (decisions, patterns)   (evaluator)    (inbox → memory)
```

Claude loads your context at session start, watches for decisions and insights during the session, and runs a structured closure routine when you're done. Nothing is written to permanent memory without your approval.

## Install

```bash
git clone https://github.com/<you>/context-governance ~/context
cd ~/context && ./install.sh
```

Then follow the printed instructions to update your `~/.claude/CLAUDE.md`.

Run `/cg-setup` in any Claude Code session to populate your identity, preferences, and first project.

## Commands

| Command | What it does |
|---------|-------------|
| `/cg-setup` | First-time guided setup — populates identity, preferences, non-negotiables |
| `/cg-status` | Show active projects, inbox count, open checkpoint |
| `/cg-new-project` | Register a new project with context files |
| `/cg-checkpoint` | Save session state for restart |
| `/cg-close` | Run session closure — surface decisions, stage memory updates, commit |
| `/cg-review` | Review and merge pending inbox items into permanent memory |
| `/cg-archive` | Archive a completed or paused project |

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

## The inbox / approval model

Claude never writes to permanent memory directly. Everything goes through `inbox/` first:

```
session insight
    ↓
inbox/20260324-1430--my-project--chose-postgres--decision.md
    ↓
/cg-review  (you approve, edit, or discard)
    ↓
projects/_active/my-project/decisions.md
    ↓
git commit
```

## Requirements

- [Claude Code](https://claude.ai/code)
- Python 3 (stdlib only — no packages to install)
- git

## Customization

After installing, the files in `global/` and `human/` are yours to edit freely. They're loaded every session. The examples committed to this repo show what each file is for — replace them with your own content, or run `/cg-setup` to be guided through it.

## Project structure

```
~/context/
├── bin/                  # Shell helpers (called by commands)
│   ├── cg_lib.py         # Shared library — YAML parser, slug resolution
│   ├── cg-slug           # Resolve CWD → project slug
│   ├── cg-check-conflicts # Detect open checkpoint / inbox / uncommitted
│   ├── cg-inbox-stage    # Write approval-gated items to inbox/
│   └── cg-history-append # Append session entry to history
├── commands/             # Slash command definitions (installed to ~/.claude/commands/)
├── governance/           # System rules and templates
│   ├── skill.md          # Pipeline rules
│   ├── triggers.yaml     # When each stage fires
│   └── templates/        # checkpoint.md, manifest.md, write-back.md
├── projects/
│   ├── _template/        # Scaffold for new projects
│   ├── _active/          # Your active projects (gitignored)
│   └── _archived/        # Archived projects (gitignored)
├── domains/              # Domain-specific memory
├── install.sh            # One-time install script
└── docs/
    └── claude-md-snippet.md  # Instructions for ~/.claude/CLAUDE.md
```

## License

MIT
