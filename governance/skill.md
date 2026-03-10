# Context Governance Skill — v0.0

> Core pipeline rules for any AI tool using this system.
> CLAUDE.md is the Claude Code implementation.

## The pipeline
CONSTRUCT → MONITOR → EVALUATE → WRITE-BACK → (back to memory)

## Context layers (load priority)
1. human/non-negotiables.md       — always, always wins
2. human/preferences.yaml         — always
3. global/identity.md             — always
4. global/principles.md           — always
5. registry.yaml                  — always (project detection)
6. projects/_active/{slug}/context.yaml  — when project identified
7. projects/_active/{slug}/memory.md     — when project identified
8. projects/_active/{slug}/decisions.md  — when project identified
9. domains/{domain}/memory.md            — based on task type
10. global/cross-pollination.md          — synthesis/cross-domain tasks
11. scratchpad/checkpoint.md             — if exists (resuming)

## Governance rules
| Resource                    | Auto | Needs approval | Git |
|-----------------------------|------|----------------|-----|
| scratchpad/                 | yes  | no             | no  |
| history/                    | yes  | granularity    | yes |
| inbox/                      | yes  | yes (to merge) | tmp |
| projects/*/memory.md        | no   | yes            | yes |
| projects/*/decisions.md     | no   | yes            | yes |
| domains/*/memory.md         | no   | yes            | yes |
| global/cross-pollination.md | no   | yes            | yes |
| human/                      | no   | user edits     | yes |
| registry.yaml               | no   | user edits     | yes |
