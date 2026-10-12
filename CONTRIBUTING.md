# Contributing

## Repo layout

| Path | Purpose |
| --- | --- |
| `sources.json` | Version and per-architecture hash of every app. |
| `update.sh` | Update logic (see below). |
| `nix/apps.nix` | Catalogue of apps: name and description. |
| `nix/package.nix` | Generic builder that wraps one upstream AppImage. |
| `nix/packages.nix` | Joins `apps.nix`, `sources.json` and the builder into one package set. |
| `nix/modules.nix` | The NixOS and Home Manager modules (`programs.artcraft`). |
| `flake.nix` | Flake outputs for `x86_64-linux` and `aarch64-linux`. |
| `.github/workflows/check.yml` | Run on every pull request. |
| `.github/workflows/update-lock.yml` | Weekly refresh of `flake.lock`. |
| `.github/workflows/update.yml` | Daily update job. |


## How updates work

`update.sh` needs `bash`, `curl`, `jq`, `awk` and `base64` (or run `nix run .#update`).
For every app in `sources.json` (or the ones you pass as arguments) it:

1. Resolves the latest stable tag from the redirect of `https://github.com/storytold/<app>/releases/latest`.
2. Skips the app if that version is already in `sources.json`.
3. Downloads `SHA256SUMS.txt` of that release and picks the x86_64 and aarch64 AppImage lines.
4. Converts the hex hashes to Nix's `sha256-...` format and rewrites the app's entry.

It prints `<app>: <old> -> <new>` per bump. If an app
fails, the others are still updated and the script exits with 1.

The workflow runs daily. If `sources.json` changed, it builds the bumped apps and only then
commits (`nix build` checks the new hashes and that the desktop file and icons are still where
`package.nix` expects them). A failed app does not block the others: their bumps are committed and
the run is marked failed at the end.

## Adding an app

1. Add it to `nix/apps.nix`. The attribute name is the package name and must equal the repo name:
   ```nix
   newcraft.description = "What it does";
   ```
   Use the summary from the app's own metainfo where possible.
2. Add an empty entry to `sources.json`:
   ```json
   "newcraft": {}
   ```
3. Fetch version and hashes:
   ```sh
   ./update.sh newcraft
   ```
4. Add a row to the table in `README.md` (name linked to the repo, description as in `apps.nix`, and a
   version badge).
5. Check that it builds: `nix build .#newcraft`, then `nix flake check`.

### What an app has to look like

- The repo is `storytold/<name>`.
- The release tag is `v<version>`.
- The assets are `<name>-<version>-linux-x86_64.AppImage` and `...-linux-aarch64.AppImage`.
- The release contains a `SHA256SUMS.txt` that lists both.
- Inside the AppImage, with `id = ai.storyteller.<name>`: `<id>.desktop`,
  `usr/share/mime/packages/<id>.xml`, `usr/share/metainfo/<id>.metainfo.xml` and `usr/share/icons`.
- The executable on `PATH` is called `<name>` (the desktop file's `Exec=` line uses it).

Inspect an AppImage:

```sh
./newcraft-1.0.0-linux-x86_64.AppImage --appimage-extract
ls squashfs-root squashfs-root/usr/share
cat squashfs-root/*.desktop
```

### Missing libraries at runtime

The apps load libraries such as Vulkan, Wayland and X11 with `dlopen` at runtime, so `ldd` will not
show them. The default FHS environment of `appimageTools` already provides most of them; `libva` is
added in `package.nix` via `extraPkgs`. If something is missing, add the nixpkgs package to `extraPkgs` in `nix/package.nix`.

## Testing changes

`nix develop` gives you the CI tools.

```sh
nix fmt                        # format all Nix files
shellcheck update.sh
nix flake check --all-systems  # evaluates every package for both architectures
nix build .#photocraft         # downloads, extracts and wraps one app
```

Every pull request runs [`check.yml`](.github/workflows/check.yml):

| Step | Command | Fix locally with |
| --- | --- | --- |
| Formatting | `nix fmt -- --ci` | `nix fmt` |
| Shell script | `shellcheck update.sh` | |
| Workflow files | `actionlint` | |
| Data file | `jq empty sources.json` | |
| Flake | `nix flake check --all-systems` | |
| Build (x86_64 and aarch64) | `nix build .#all` | |

## Notes

- The checksums come from the same GitHub release as the binaries. They detect a corrupted
  download but not a compromised upstream release. Upstream attestation support has not been
  looked into yet;
- Only the GUI binary is exposed. The AppImages also contain `<app>-cli` tools, which the
  `wrapType2` wrapper does not make available.
