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

## Phases

**Phase 1 — Welcome**
Explain the system briefly: context loads at session start, insights are captured during
the session, closure stages memory with your approval. Ask if ready to begin.

**Phase 2 — Identity** (questions one at a time, no rushing)
Q1: How do you like to work with an AI? Options vs recommendations? Concise vs thorough? Push back or follow your lead?
Q2: How do you make decisions? Explore first or straight to execution? Pros/cons or bottom line?
Q3: What are you most focused on right now, professionally and intellectually?
Q4: What does good output look like to you?
→ Write `~/context/global/identity.md`. Show it. Ask for corrections.

**Phase 3 — Principles**
Q5: What 3–5 beliefs guide your work across everything you do?
Q6: What's something you've learned the hard way that you now always apply?
→ Write `~/context/global/principles.md`. Show it. Ask for corrections.

**Phase 4 — Non-negotiables and preferences**
Q7: What should I never do when working with you?
Q8: What should I always check with you before doing?
Q9: Any preferences for tone, response length, or how I format things?
→ Write `~/context/human/non-negotiables.md` and `preferences.yaml`. Show both. Confirm.

**Phase 5 — Domains**
Q10: What domains are you actively working in? (coding, writing, design, research, etc.)
For each domain named:
- Create `~/context/domains/{domain}/memory.md`
- Ask one seed question (coding→stack, writing→voice, design→sensibility, other→most important thing to know)
- Write the answer into that domain's memory.md

**Phase 6 — First project (optional)**
Q11: Want to set up a project now? You can always do this later with `/cg-new-project`.
If yes: run the /cg-new-project flow inline.

**Phase 7 — Finalize**
Update `~/context/registry.yaml`:
- Add all domains collected above
- Set `system.initiated: true` and `initiated_at: {today}`

Commit: `cd ~/context && git add -A && git commit -m "init: context governance setup"`

Tell the user clearly:
- What files were created
- What loads automatically at every session start
- What to do when starting a new project (`/cg-new-project`)
- What to do at the end of a session (`/cg-close`)
