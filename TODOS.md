# TODOS — Context Governance System

Items deferred from design + review phase. See CEO plan for full context.

---

## P2 — Constructor auto-invocation failure mode

**What:** Document failure mode explicitly in CLAUDE.md global instructions. Add a "Did you run the constructor?" fast-path recovery note to each `/cg-*` skill's preamble (one sentence: "If you haven't run /cg-constructor this session, do that first.").

**Why:** The system relies on user discipline. If constructor isn't run, no context is loaded — silently. The manifest guard fails other skills loudly after-the-fact, but doesn't prevent the failure.

**Pros:** Zero implementation cost. Makes the assumption explicit and recoverable.

**Cons:** Still discipline-dependent. Does not solve the root cause.

**Context:** Root cause fix (hooks-triggered constructor) is deferred to v2 — hooks API is unstable in v1. This TODO is the v1 mitigation. Add a one-liner to each skill's intro: "Requires /cg-constructor to have been run this session."

**Effort:** S (human: 30min / CC: 5min)
**Priority:** P2
**Depends on:** All skills (add during implementation or as a post-v1 pass)

---

## P2 — Multi-session manifest safety

**What:** Name manifests with a session timestamp: `scratchpad/manifest-{YYYYMMDD-HHMM}.md`. `/cg-status` reads the most recent. `/cg-close` deletes or archives its own manifest on closure.

**Why:** Two simultaneous Claude sessions (one terminal per project) both write to `scratchpad/manifest.md` and overwrite each other. `/cg-status` then reports the wrong project for one session.

**Pros:** Correct multi-session behavior. `/cg-status` always reflects the current session.

**Cons:** Adds manifest cleanup logic to `/cg-close`. Old manifests accumulate if `/cg-close` is skipped. Need a cleanup sweep in `/cg-status` (delete manifests older than 24h).

**Context:** Personal tool — simultaneous sessions are real but low frequency. Single-session assumption is acceptable for v1 if documented. This is a v1.1 quality improvement.

**Effort:** S (human: 1hr / CC: 10min)
**Priority:** P2
**Depends on:** manifest.md template, cg-constructor, cg-close, cg-status

---

## Deferred from CEO plan scope review

See `~/.gstack/projects/context/ceo-plans/2026-03-23-context-governance-skills.md` for full scope decisions.

- **`/cg-distill`** — memory compression; trigger when memory.md > ~50 entries; archive originals to `memory.archive.md`
- **`/cg-synthesize`** — cross-domain synthesis; requires proven core loop + real domain memory content
- **Context quality metrics** — after 10+ sessions logged; write to `~/.context/metrics/`
- **Session type presets** — after manifest confirmation pattern proven
- **Multi-tool adapters** (Codex, Gemini) — file format portable; adapters are phase 2
- **Hooks-triggered constructor** — defer until SKILL.md approach is proven unreliable; hooks API is v2
- **`cg-archive --restore`** — mark v2 explicitly; archive-only is sufficient for v1
