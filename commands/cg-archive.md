# /cg-archive — Archive a Project

List active projects from ~/context/registry.yaml.
Ask: "Which project do you want to archive?"
Confirm: "Archive {slug}? This moves it to _archived/ and removes it from active loading."

If confirmed:
- mv ~/context/projects/_active/{slug} ~/context/projects/_archived/{slug}
- Update registry.yaml: status → archived
- If CLAUDE.md symlink exists in repo: ask "Remove the symlink in {repo-path}?"
- Say: "{slug} archived. It won't load in future sessions unless you ask."
- Commit: git add -A && git commit -m "{date}: archived {slug}"
