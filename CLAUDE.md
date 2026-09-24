# CenteredUI

World of Warcraft addon (Siz CenteredUI). Addon folder name is `CenteredUI`; the GitHub repo is `Coldensjo/SizCenteredUI`.

- CurseForge: https://www.curseforge.com/wow/addons/siz-ultrawide-centeredui (project ID 1709846)
- GitHub: https://github.com/Coldensjo/SizCenteredUI

## Releasing (CurseForge automatic packaging)

CurseForge builds and uploads the zip itself through a GitHub webhook
(`https://www.curseforge.com/api/projects/1709846/package?token=...`). Nothing is built locally.

- Every push must be tagged, so each pushed change ships as a Release instead of an untagged Alpha:
	- Find the latest tag with `git tag --sort=-v:refname | head -1` and bump it: patch (`1.0.1`) for fixes, minor (`1.1.0`) for new features. If no tags exist yet, ask the user for the starting version.
	- Commit, then tag and push branch and tag together: `git tag 1.0.1 && git push origin master 1.0.1`.
	- Only use a tag containing `alpha` or `beta` when the user asks for a test build.
	- Tag containing `alpha` → Alpha, containing `beta` → Beta, anything else → Release. A push with no tag becomes an Alpha.
- `.pkgmeta` controls packaging:
	- `package-as: CenteredUI` must stay equal to the `.toc` name, or the game will not load the addon (the repo name differs).
	- Add new non-addon files (docs, tools, config) to its `ignore:` list so they stay out of the zip.
	- It is YAML: indent with spaces, not tabs.
- `CenteredUI.toc`:
	- `## Version: @project-version@` is replaced with the tag by the packager; do not hard-code a version.
	- `## X-Curse-Project-ID: 1709846` links the addon to the CurseForge project.
	- The packager reads the game version from `## Interface:`. If an upload fails or shows the wrong game version, check that value first.
- New Lua/XML files must be listed in the `.toc` to be loaded.
- Never commit the CurseForge API token; it only belongs in the GitHub webhook settings.

## Code style

- Indent with tabs (tab size 4), except YAML (`.pkgmeta`).
- The existing Lua still uses 2 spaces. When editing a file, convert the whole file to tabs rather than mixing styles.
