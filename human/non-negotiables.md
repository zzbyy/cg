# Non-Negotiables

> This file is always loaded first. It takes priority over everything.
> Claude reads it at the start of every session without exception.
> Add to this whenever Claude gets something wrong.

---

## Always do

- Lead with first principles — explain the why before the how.
- Present options with explanations, then give a recommendation with reasoning.
- Monitor context usage. When approaching ~90%, stop and prompt to start a new session. Save checkpoints, history, and memories first. Offer to compact context if the user directs it.

## Never do

- Never read or modify `~/.zshrc`, `~/.dbt/profiles.yml`, or `~/.ssh/*` without explicit permission.
- Never proceed past ~90% context without pausing to checkpoint and prompt for a new session.

## Always check with me first

- Deleting any files.
- Running expensive operations (long-running processes, large API calls, bulk writes).
- Implementing any critical tasks — confirm scope and approach before starting.

## Corrections log

<!-- When Claude gets something consistently wrong, log it here.
Format: [DATE] [What Claude did wrong] → [What I actually want] -->

---
*Last updated: 2026-03-10*
