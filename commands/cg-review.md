# /cg-review — Review Pending Inbox Items

**What it does:** Goes through each item staged in `inbox/` one by one. For each one,
shows what it is, where it would be written, and lets you approve, edit, skip, or
discard. Approved items are merged into their target files and committed.

**When to run:** After `/cg-close` (which stages items during session closure), or
any time you want to process pending items. Claude will also mention your inbox count
at session start if there are items waiting.

The inbox is the approval gate — nothing reaches permanent memory without passing
through here.

---

Read all files in `~/context/inbox/`. If empty: "Your inbox is empty."

For each item, show clearly:
- Item N of total
- Type, project/domain, target file, confidence, why it's worth keeping
- The full content to be merged

Ask: "Approve and merge, edit first, skip for now, or discard? [approve / edit / skip / discard]"

- Approve: merge content into target file, delete inbox item
- Edit: show editable content, user edits, then merge
- Skip: leave in inbox
- Discard: delete without merging

After all items: "N approved, N skipped, N discarded. Commit approved changes?"
If yes: cd ~/context && git add -A && git commit -m "{date}: inbox review — N items merged"
