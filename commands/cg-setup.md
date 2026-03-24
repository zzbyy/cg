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

If `system.initiated` is `false` (or the field is missing): begin Phase 1 immediately.
**Critical:** Do NOT say "setup has not been run", "setup hasn't been completed", or any variant.
Do NOT announce the state of the system. Do NOT use "Let's go" as an opener.
Print the Welcome header and begin the welcome narrative — nothing else.

## Phases

**Welcome**
Print the header: `## Welcome`

Open with this narrative (write it as flowing prose, not a list):

"Every time you start a new Claude session, you probably spend the first few messages
re-establishing who you are, what you're working on, how you like to operate. The AI is
capable but amnesiac — blank slate, every time.

This system ends that. Once set up, I load your context automatically at the start of every
session: who you are, what you're building, your working style, your hard rules, any
decisions you made last time, any checkpoints left open. You never re-explain yourself.

We'll spend about 10–15 minutes building three things together: a profile of how you work,
a set of principles and rules I'll always follow, and a memory structure that grows with you
over time. At the end of each session, I'll propose what's worth saving. Nothing gets written
to permanent memory without your approval."

Use AskUserQuestion: "Ready to begin?" with options A) Let's go and B) Tell me more first.

If B: explain the Constructor (loads context at start), Monitor (watches for decisions worth
keeping mid-session), and Evaluator (stages approved items at close). Then ask again.

**Phase 1 — Identity**
Print the header: `## Phase 1 — Identity`
Ask each question using AskUserQuestion, one at a time. Wait for the answer before asking the next.

Q0 — Who are you:
  "Describe yourself in one sentence — role, domain, and stage."
  A) Solo founder / indie builder
  B) Engineer at a company (startup / mid / large)
  C) Researcher, student, or academic
  D) Something else — I'll describe it
  (If D or Other: ask them to describe themselves in one sentence)

Q1 — Collaboration depth:
  "When I respond, what do you want?"
  A) Just the answer — assume I'm competent, be concise
  B) Answer + reasoning — I want to understand why
  C) Depends — concise for simple things, full context for complex decisions

Q2 — Decision making:
  "How do you make decisions?"
  A) Explore first, then decide — I need to see the landscape
  B) Bottom line first — give me the recommendation, I'll ask if I want more
  C) Straight to execution — I have enough context, let's go

Q3 — Current focus (open, but offer starters):
  "What are you most focused on right now, professionally or intellectually?"
  A) Building a product or startup
  B) Engineering or technical work at a company
  C) Research, learning, or writing
  D) Something else — I'll describe it
  (If D or Other: ask them to describe it in one sentence)

After collecting all answers, compose the draft content for `~/context/global/identity.md`.
The first section must be "Who you are" derived from Q0 — this anchors everything else.
Then include working style (from Q1), decision-making (from Q2), and current focus (from Q3).

Note: Q1 and Q2 also map to preferences.yaml fields — carry these answers forward
to Phase 3 when composing preferences.yaml:
- Q1 → communication.response_length (A→concise, B→thorough, C→balanced)
- Q2 → decisions.style (A→explore-together, B→bottom-line-first, C→bottom-line-first)
       decisions.show_rationale (A→on-request, B→on-request, C→on-request)

Then use AskUserQuestion to present the draft:

"Here's what I'll write to identity.md:

---
{draft content}
---

A) Save it — looks right
B) Change something — I'll describe what to fix
C) Redo this phase — ask the questions again"

If B: ask what to change, update the draft, and re-present via AskUserQuestion before writing.
If C: restart Phase 1 questions from Q0.
Only write the file after A is chosen.

**Phase 2 — Principles**
Print the header: `## Phase 2 — Principles`
Ask each question using AskUserQuestion.

Q4 — Core beliefs (open, offer archetypes + anti-pattern option):
  "What beliefs guide your work? Pick any that resonate, or write your own."
  (multiSelect: true)
  A) Ship small and verify — don't over-plan
  B) Understand deeply before acting — slow is smooth
  C) People and relationships first — process follows
  D) Constraints are creative — limits produce better work
  E) Something I've learned NOT to do — I'll describe an anti-pattern
  F) Something else — I'll write my own belief
  (If E or F or Other: ask them to state their belief or anti-pattern in their own words)

Q5 — Hard-won lessons (open, offer starters):
  "What are 1–3 things you've learned the hard way that you now always apply?"
  A) Move fast but always test the thing you changed
  B) Say the hard thing early — surprises are worse later
  C) Document decisions, not just outcomes
  D) Something else — I'll describe mine
  (If D or Other: ask for their answer; they can list multiple)

After collecting all answers, compose the draft content for `~/context/global/principles.md`.
Then use AskUserQuestion to present it:

"Here's what I'll write to principles.md:

---
{draft content}
---

A) Save it — looks right
B) Change something — I'll describe what to fix
C) Redo this phase — ask the questions again"

If B: ask what to change, update the draft, and re-present via AskUserQuestion before writing.
If C: restart Phase 2 questions from Q4.
Only write the file after A is chosen.

**Phase 3 — Non-negotiables & Preferences**
Print the header: `## Phase 3 — Non-negotiables & Preferences`
Ask each question using AskUserQuestion.

Q6 — Never do (multiselect + Other):
  "What should I never do without asking you first?"
  (multiSelect: true)
  A) Commit or push code
  B) Refactor code I didn't ask you to touch
  C) Add features or behavior beyond what I asked for
  D) Delete or move files
  E) Something else — I'll describe it
  (If E or Other: ask them to add their own rule)

Q7 — Always do (multiselect + Other):
  "What should I always do, even if you forget to ask?"
  (multiSelect: true)
  A) Always run tests after editing code
  B) Always suggest the simplest solution first
  C) Always check existing code before writing new code
  D) Always explain what you changed and why
  E) Something else — I'll describe it
  (If E or Other: ask them to describe their rule)

Q8 — Always check (multiselect + Other):
  "What decisions should I always pause and confirm with you?"
  (multiSelect: true)
  A) Before any destructive operation (delete, reset, overwrite)
  B) Before architectural or structural changes
  C) Before touching anything in production or shared environments
  D) Before changing a file I haven't explicitly mentioned
  E) Something else — I'll describe it

Q9 — Tone, format, and code preferences (multiselect):
  "Any preferences for how I communicate and write code?"
  (multiSelect: true)
  A) No emojis
  B) No preamble — get to the point immediately
  C) Use markdown tables and structure when helpful
  D) Plain prose — avoid heavy formatting
  E) Never summarize what you just did at the end
  F) Prefer concise code with minimal comments
  G) Prefer well-commented code with explanations
  H) Other — I'll describe it

After collecting all answers, compose the draft content for both files.

non-negotiables.md mapping:
- Q7 answers → "Always do" section
- Q6 answers → "Never do" section
- Q8 answers → "Always check with me first" section

preferences.yaml mapping (combine with Q1 and Q2 answers from Phase 1):
- Q1 answer → communication.response_length (A→concise, B→thorough, C→balanced)
- Q2 answer → decisions.style (A→explore-together, B→bottom-line-first, C→bottom-line-first)
              decisions.show_rationale (A→on-request, B→on-request, C→on-request)
- Q9 A,B,D,E → communication.tone or communication.pushback notes
- Q9 F → code.comments: minimal
- Q9 G → code.comments: detailed

Then use AskUserQuestion to present them:

"Here's what I'll write to non-negotiables.md and preferences.yaml:

--- non-negotiables.md ---
{draft content}

--- preferences.yaml ---
{draft content}
---

A) Save both — looks right
B) Change something — I'll describe what to fix
C) Redo this phase — ask the questions again"

If B: ask what to change, update the drafts, and re-present via AskUserQuestion before writing.
If C: restart Phase 3 questions from Q6.
Only write the files after A is chosen.

**Phase 4 — Domains**
Print the header: `## Phase 4 — Domains`

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

For each selected domain, ask two seed questions via AskUserQuestion with 3–4 suggested
answers plus Other:

Coding:
- Q10a: "What's your primary stack?" (options: Rails/Ruby, Next.js/TypeScript, Python, Go, Other)
- Q10b: "What matters most in your code?" (options: readability, performance, simplicity, test coverage, Other)

Writing:
- Q10a: "What's your default voice/audience?" (options: technical, narrative, business, academic, Other)
- Q10b: "What do you actively avoid in writing?" (options: jargon, passive voice, long paragraphs, over-explaining, Other)

Design:
- Q10a: "What's your design sensibility?" (options: minimal/functional, bold/expressive, system-driven, Other)
- Q10b: "What design tool do you primarily use?" (options: Figma, Framer, CSS/code-first, Sketch, Other)

Research:
- Q10a: "What matters most in your research process?" (options: depth over speed, structured frameworks, serendipitous connections, Other)
- Q10b: "How do you organize your findings?" (options: notes app, structured docs, tagging/linking, Other)

Data:
- Q10a: "What's your primary data environment?" (options: SQL/warehouses, Python/notebooks, dashboards/BI tools, Other)
- Q10b: "What's your testing/validation approach?" (options: manual spot checks, automated tests, peer review, Other)

Other domains:
- Q10a: "What's the most important thing to know about how you work in this domain?" (open with Other)
- Q10b: "What tool or workflow is central to this domain for you?" (open with Other)

For each domain, after both seed questions are answered, compose the draft content for
`~/context/domains/{domain}/memory.md`. Then use AskUserQuestion to present it:

"Here's what I'll write to domains/{domain}/memory.md:

---
{draft content}
---

A) Save it — looks right
B) Change something — I'll describe what to fix
C) Skip this domain"

If B: ask what to change, update the draft, and re-present via AskUserQuestion before writing.
Only write the file after A is chosen.

**Phase 5 — First project (optional)**
Print the header: `## Phase 5 — First Project (optional)`

Use AskUserQuestion:
  "Want to set up a project now? You can always do this later with /cg-new-project."
  A) Yes — set up my first project now
  B) Skip for now — I'll run /cg-new-project later

If A: run the /cg-new-project flow inline.

**Phase 6 — Finalize**
Print the header: `## Phase 6 — Finalize`
Update `~/context/registry.yaml`:
- Add all domains collected above
- Set `system.initiated: true` and `initiated_at: {today}`

Commit: `cd ~/context && git add -A && git commit -m "init: context governance setup"`

Tell the user clearly:
- What files were created
- What loads automatically at every session start
- What to do when starting a new project (`/cg-new-project`)
- What to do at the end of a session (`/cg-close`)
