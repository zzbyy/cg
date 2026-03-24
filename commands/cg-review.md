# /cg-review — Review Inbox Items

Read all files in ~/context/inbox/. If empty: "Your inbox is empty."

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
