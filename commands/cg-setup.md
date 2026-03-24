# /cg-setup — First-Time Setup

**What it does:** Walks you through a guided interview to populate your context system
from scratch — identity, working style, principles, hard rules, preferences, domains,
and optionally a first project. Takes about 10–15 minutes.

**When to run:** Once, right after installing context-governance. If you've already
run it, use `/cg-new-project` to add a project or edit the files in `global/` and
`human/` directly.

---

Check `~/context/registry.yaml` first. If `system.initiated` is `true`, say:
"Setup is already complete (initiated {initiated_at}). Did you mean `/cg-status` or `/cg-new-project`?"
Then stop — do not run any phases.

Otherwise, go straight to Phase 1 with no preamble.

## Phases

**Phase 1 — Welcome**
Print the header: `## Phase 1 — Welcome`
Open directly: "Let's build your context system. This takes about 10–15 minutes and you'll only do it once."
Then explain what we're building: context that loads at every session start, a monitor that
watches for decisions and insights worth keeping, and a closure routine that stages what's
worth saving for your approval before committing anything.
Use AskUserQuestion: "Ready to begin?" with options A) Let's go and B) Tell me more first.

**Phase 2 — Identity**
Print the header: `## Phase 2 — Identity`
Ask each question using AskUserQuestion, one at a time. Wait for the answer before asking the next.

Q1 — Working style:
  "How do you like to work with an AI?"
  A) Give me options and let me decide — I like seeing the tradeoffs
  B) Just tell me what you'd do — I trust your judgment, move fast
  C) Mixed — recommendations usually, options for big decisions

Q2 — Decision making:
  "How do you make decisions?"
  A) Explore first, then decide — I need to understand the landscape
  B) Bottom line first — give me the recommendation, I'll ask if I want more
  C) Straight to execution — I have enough context, let's go

Q3 — Current focus (open, but offer starters):
  "What are you most focused on right now, professionally or intellectually?"
  A) Building a product or startup
  B) Engineering or technical work at a company
  C) Research, learning, or writing
  D) Something else — I'll describe it
  (If D or Other: ask them to describe it in one sentence)

Q4 — Good output:
  "What does good output look like to you?"
  A) Concise — short answers that assume I'm competent
  B) Thorough — full context and reasoning, I like to understand why
  C) Depends — concise for simple things, thorough for complex decisions

→ Write `~/context/global/identity.md` from the answers. Show it. Ask for corrections.

**Phase 3 — Principles**
Print the header: `## Phase 3 — Principles`
Ask each question using AskUserQuestion.

Q5 — Core beliefs (open, offer archetypes):
  "What beliefs guide your work? Pick any that resonate, or describe your own."
  (multiSelect: true)
  A) Ship small and verify — don't over-plan
  B) Understand deeply before acting — slow is smooth
  C) People and relationships first — process follows
  D) Constraints are creative — limits produce better work
  E) Something else — I'll write my own
  (If E or Other: ask them to state 1–3 beliefs in their own words)

Q6 — Hard-won lessons (open, offer starters):
  "What's something you've learned the hard way that you now always apply?"
  A) Move fast but always test the thing you changed
  B) Say the hard thing early — surprises are worse later
  C) Document decisions, not just outcomes
  D) Something else — I'll describe it
  (If D or Other: ask for their answer)

→ Write `~/context/global/principles.md`. Show it. Ask for corrections.

**Phase 4 — Non-negotiables & Preferences**
Print the header: `## Phase 4 — Non-negotiables & Preferences`
Ask each question using AskUserQuestion.

Q7 — Never do (multiselect + Other):
  "What should I never do without asking you first?"
  (multiSelect: true)
  A) Commit or push code
  B) Refactor code I didn't ask you to touch
  C) Add features or behavior beyond what I asked for
  D) Delete or move files
  E) Something else — I'll describe it
  (If E or Other: ask them to add their own rule)

Q8 — Always check (multiselect + Other):
  "What decisions should I always pause and confirm with you?"
  (multiSelect: true)
  A) Before any destructive operation (delete, reset, overwrite)
  B) Before architectural or structural changes
  C) Before touching anything in production or shared environments
  D) Before changing a file I haven't explicitly mentioned
  E) Something else — I'll describe it

Q9 — Tone and format preferences (multiselect):
  "Any preferences for how I communicate?"
  (multiSelect: true)
  A) No emojis
  B) No preamble — get to the point immediately
  C) Use markdown tables and structure when helpful
  D) Plain prose — avoid heavy formatting
  E) Never summarize what you just did at the end
  F) Other — I'll describe it

→ Write `~/context/human/non-negotiables.md` and `preferences.yaml` from the answers. Show both. Confirm.

**Phase 5 — Domains**
Print the header: `## Phase 5 — Domains`

Q10 — Active domains (multiselect):
  "What domains are you actively working in?"
  (multiSelect: true)
  A) Coding / software engineering
  B) Writing / content
  C) Design / product
  D) Research / analysis
  E) Data / analytics
  F) Other — I'll name it
  (If F or Other: ask them to name the domain)

For each selected domain, ask one seed question via AskUserQuestion with 3–4 suggested
answers plus Other:
- Coding → "What's your primary stack?" (options: Rails/Ruby, Next.js/TypeScript, Python, Go, Other)
- Writing → "What's your default voice/audience?" (options: technical, narrative, business, academic, Other)
- Design → "What's your design sensibility?" (options: minimal/functional, bold/expressive, system-driven, Other)
- Research → "What matters most in your research process?" (options: depth over speed, structured frameworks, serendipitous connections, Other)
- Data → "What's your primary data environment?" (options: SQL/warehouses, Python/notebooks, dashboards/BI tools, Other)
- Other domains → "What's the most important thing to know about how you work in this domain?" (open with Other)

Write each domain's answer into `~/context/domains/{domain}/memory.md`.

**Phase 6 — First project (optional)**
Print the header: `## Phase 6 — First Project (optional)`

Use AskUserQuestion:
  "Want to set up a project now? You can always do this later with /cg-new-project."
  A) Yes — set up my first project now
  B) Skip for now — I'll run /cg-new-project later

If A: run the /cg-new-project flow inline.

**Phase 7 — Finalize**
Print the header: `## Phase 7 — Finalize`
Update `~/context/registry.yaml`:
- Add all domains collected above
- Set `system.initiated: true` and `initiated_at: {today}`

Commit: `cd ~/context && git add -A && git commit -m "init: context governance setup"`

Tell the user clearly:
- What files were created
- What loads automatically at every session start
- What to do when starting a new project (`/cg-new-project`)
- What to do at the end of a session (`/cg-close`)
