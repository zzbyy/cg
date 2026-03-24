# /cg-new-project — Add a New Project

Guide the user through setting up a new project in the context system.

Ask sequentially:
1. Project name/slug?
2. One sentence — what is this and what are you trying to achieve?
3. Current status? (planning / active / blocked)
4. What types of work? (coding, writing, design, etc.)
5. Existing repo or folder on your Mac?
   - If yes: record path. Offer CLAUDE.md symlink: `ln -sf ~/context/projects/_active/{slug}/CLAUDE.md {repo}/CLAUDE.md`
6. Seed questions based on domains (coding→stack, writing→audience+tone, design→constraints, general→most important context)

Create ~/context/projects/_active/{slug}/ with:
- context.yaml (machine-readable metadata)
- brief.md (from Q1, Q2, Q6 answers)
- memory.md (from seed question answers)
- decisions.md (empty log)
- tasks.md (ask: what are the immediate next actions?)
- CLAUDE.md (project-specific instructions)

Update ~/context/registry.yaml with the new project entry.

Show what was created. Ask: "Want to start working on this project now?"
