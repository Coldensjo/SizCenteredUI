# CenteredUI

World of Warcraft addon (Siz CenteredUI). Addon folder name is `CenteredUI`; the GitHub repo is `Coldensjo/SizCenteredUI`.

- CurseForge: project not set up yet. Once it exists, add its URL and project ID here and `## X-Curse-Project-ID: <id>` to `CenteredUI.toc`.
- GitHub: https://github.com/Coldensjo/SizCenteredUI

## Releasing (CurseForge automatic packaging)

CurseForge builds and uploads the zip itself through a GitHub webhook
(`https://www.curseforge.com/api/projects/<projectID>/package?token=...`). Nothing is built locally.

- A release is made by pushing a git tag: `git tag 1.0.1 && git push origin 1.0.1`.
	- Tag containing `alpha` → Alpha, containing `beta` → Beta, anything else → Release.
- `.pkgmeta` controls packaging:
	- `package-as: CenteredUI` must stay equal to the `.toc` name, or the game will not load the addon (the repo name differs).
	- Add new non-addon files (docs, tools, config) to its `ignore:` list so they stay out of the zip.
	- It is YAML: indent with spaces, not tabs.
- `CenteredUI.toc`:
	- `## Version: @project-version@` is replaced with the tag by the packager; do not hard-code a version.
	- The packager reads the game version from `## Interface:`. If an upload fails or shows the wrong game version, check that value first.
- New Lua/XML files must be listed in the `.toc` to be loaded.
- Never commit the CurseForge API token; it only belongs in the GitHub webhook settings.

## Code style

- Indent with tabs (tab size 4), except YAML (`.pkgmeta`).
- The existing Lua still uses 2 spaces. When editing a file, convert the whole file to tabs rather than mixing styles.
