# History — Session Log Format

> Logs are append-only. Never edited after committed.
> Granularity is asked at each session close. Medium is default.
> Naming: history/{YYYY-MM-DD}/{project-slug}.md

## Light
```
# {DATE} — {PROJECT}
**Task:** one line
**Outcome:** one sentence
```

## Medium (default)
```
# Session Log — {DATE} — {PROJECT}
**Task:** one line
**Status:** completed / partial / blocked

## What was done
bullet summary

## Decisions made
decisions staged or confirmed

## Memory updates
what was written to memory

## Cross-pollination
insights flagged

## Next
immediate next action
```

## Heavy
Same as medium, plus: key exchanges, what didn't work, full decision records, exact memory content written.
