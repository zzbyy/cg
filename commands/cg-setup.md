# /cg-setup — First-Time Initiation

Run the context governance guided setup. Ask the user questions one at a time to build their seed files and domains. Do not rush. Do not skip phases.

Check ~/context/registry.yaml first. If system.initiated is true, say: "Setup already completed. Did you mean /cg-status or /cg-new-project?"

## Phases

**Phase 1 — Welcome**
Explain the system briefly. Ask if ready.

**Phase 2 — Identity** (questions one at a time)
Q1: How do you like to work with an AI? Options vs recommendations? Concise vs thorough? Push back or follow your lead?
Q2: How do you make decisions? Explore first or straight to execution? Pros/cons or bottom line?
Q3: What are you most focused on right now, professionally and intellectually?
Q4: What does good output look like to you?
→ Write ~/context/global/identity.md. Show it. Ask for corrections.

**Phase 3 — Principles**
Q5: What 3–5 beliefs guide your work across everything you do?
Q6: What's something you've learned the hard way that you now always apply?
→ Write ~/context/global/principles.md. Show it. Ask for corrections.

**Phase 4 — Non-negotiables**
Q7: What should I never do when working with you?
Q8: What should I always check with you before doing?
→ Write ~/context/human/non-negotiables.md and preferences.yaml. Show both. Confirm.

**Phase 5 — Domains**
Q9: What domains are you actively working in? (coding, writing, design, research, etc.)
For each domain named:
- Create ~/context/domains/{domain}/memory.md
- Ask one seed question (coding→stack, writing→voice, design→sensibility, reading→topics, other→most important thing to know)
- Write the answer into that domain's memory.md

**Phase 6 — First project (optional)**
Q10: Want to set up a project now? You can do this later with /cg-new-project.
If yes: run the /cg-new-project flow.

**Phase 7 — Finalize**
Write ~/context/registry.yaml with all collected domains and projects.
Run: cd ~/context && git init && git add -A && git commit -m "init: context governance system v0.0"
Update registry.yaml: system.initiated = true, initiated_at = today.
Tell the user: what was created, what to do next, and that the system is now live.
