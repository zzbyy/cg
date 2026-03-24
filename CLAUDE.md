# gstack

Use the `/browse` skill from gstack for all web browsing. Never use `mcp__claude-in-chrome__*` tools.

If gstack skills aren't working, run `cd .claude/skills/gstack && ./setup` to build the binary and register skills.

Available gstack skills:
- `/office-hours` — brainstorm ideas, YC-style forcing questions
- `/plan-ceo-review` — strategy review, scope expansion
- `/plan-eng-review` — architecture review, lock in execution plan
- `/plan-design-review` — designer's eye plan review
- `/design-consultation` — create full design system + DESIGN.md
- `/review` — pre-landing PR code review
- `/ship` — merge, test, bump version, create PR
- `/land-and-deploy` — land and deploy workflow
- `/canary` — canary deploy workflow
- `/benchmark` — performance benchmarking
- `/browse` — fast headless browser (screenshots, QA, dogfooding)
- `/qa` — systematic QA testing + fix bugs
- `/qa-only` — QA report only, no fixes
- `/design-review` — visual QA audit + fix design issues
- `/setup-browser-cookies` — import real browser cookies for auth
- `/setup-deploy` — configure deploy pipeline
- `/retro` — weekly engineering retrospective
- `/investigate` — systematic debugging, root cause analysis
- `/document-release` — post-ship docs update
- `/codex` — OpenAI Codex second opinion / adversarial review
- `/cso` — chief security officer review
- `/autoplan` — auto-generate implementation plan
- `/careful` — safety guardrails for destructive commands
- `/freeze` — restrict edits to a specific directory
- `/guard` — full safety mode (careful + freeze)
- `/unfreeze` — remove freeze boundary
- `/gstack-upgrade` — upgrade gstack to latest version
