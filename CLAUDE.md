# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository. `AGENTS.md` in the repo root is a symlink to this file, so OpenAI Codex and other `AGENTS.md`-aware tools pick up the same guidance.

## Repository purpose

Personal macOS dotfiles. Three provisioning scripts (`bootstrap.sh`, `make_symlinks.sh`, `mac-os_settings.sh`) deploy config files from this repo into `$HOME` and its subdirectories. All scripts are idempotent and safe to re-run.

## Common commands

```sh
./bootstrap.sh              # full provision (prompts at each step)
./bootstrap.sh --yes        # non-interactive (CI=1 is also honored)
./bootstrap.sh --skip-brew --skip-macos   # just refresh symlinks + zsh plugins
./make_symlinks.sh          # re-apply symlinks from symlinks.txt
./mac-os_settings.sh --restart-apps   # apply macOS defaults + restart Finder/Dock

brew bundle --file=Brewfile # package install only
```

No unit tests; CI validates end-to-end via `bootstrap.sh` on macos-latest — see **CI** below.

## CI

`.github/workflows/ci.yml` runs on push / PR to `master` and on `workflow_dispatch`. Single job on `macos-latest`:

1. Symlinks the checkout to `$HOME/.dotfiles` (bootstrap hardcodes that path).
2. `shellcheck bootstrap.sh make_symlinks.sh mac-os_settings.sh verify.sh`.
3. First pass: `./bootstrap.sh --yes --skip-brew --skip-chsh`.
4. `./verify.sh` — post-condition checks (symlinks, cloned repos, git config).
5. Snapshots `~/.old_dotfiles/` directory count.
6. Second pass: same bootstrap invocation again.
7. Asserts the snapshot count is unchanged (idempotency: a re-run must not back anything up).
8. Re-runs `verify.sh`.

**Bash version gotcha.** Because CI uses `--skip-brew`, homebrew's bash is never installed during the job, so `/usr/bin/env bash` resolves to macOS system `/bin/bash` (3.2). Every tracked shell script must stay compatible with bash 3.2 + `set -u`. Most common trap: expanding an empty array as `"${arr[@]}"` is an unbound-variable error in 3.2 — use `${arr[@]+"${arr[@]}"}` instead.

**What's not exercised.** `--skip-brew` skips Brewfile installation and `--skip-chsh` skips the default-shell change, so neither path is covered by CI; validate those manually when touching them. `mac-os_settings.sh` *does* run on the CI macOS image.

## Architecture

**Symlink-driven deployment.** `symlinks.txt` is the source of truth for what lands in `$HOME`. Each line is `<source> <destination>`; trailing `/` on the destination means "link into that directory using the source's basename." `make_symlinks.sh` reads this file, skips correctly-linked entries, and backs up real conflicts to `~/.old_dotfiles/<timestamp>/` before replacing them. **To add a new dotfile: drop it under a topical subdirectory and add one line to `symlinks.txt`.**

**Two-layer shell init.** `zsh/.zshenv` runs for every zsh invocation (login, interactive, scripts) and owns `$PATH`, language toolchain init (rbenv, nodenv, cargo, direnv, mise indirectly), and sourcing the untracked `work_machine_setup.env`. `zsh/.zshrc` runs only for interactive shells and owns prompt (starship via `eval`), plugins (antidote-bundled into `~/.zsh_plugins.zsh` by bootstrap), history, completions, fzf, and `zsh/aliases.zsh`.

**Antidote plugin bundling.** Plugins are declared in `zsh/.zsh_plugins.txt`. `bootstrap.sh` runs `antidote bundle` to generate `~/.zsh_plugins.zsh`, which `.zshrc` sources. Editing `.zsh_plugins.txt` requires re-running bootstrap (or re-running the antidote line) to regenerate the bundle.

**Work-machine layering.** Anything Netflix-specific or secret lives in untracked overlay files, loaded only if present:
- `work_machine_setup.env` — sourced at the end of `zsh/.zshenv` (gitignored)
- `~/.lldbinit.local` — sourced from `lldb/.lldbinit` (also gitignored by convention)
- `~/.sbn_aliases` — sourced from both `.zshrc` and `bash/.bashrc`

Keep these pathways when adding work-only config; do not commit work-specific values into tracked files.

**External repos cloned by bootstrap (not vendored):** `~/.lldb/LLDB` (DerekSelander), `~/.tmux/plugins/tpm`. These are fetched on first bootstrap and assumed present afterward.

## Directory layout

| Dir | Contents |
|---|---|
| `bash/` | `.bash_profile`, `.bashrc` — legacy, kept for scripts that default to bash |
| `zsh/` | `.zshenv`, `.zshrc`, `.fzf.zsh`, `aliases.zsh`, `fzf-funcs.zsh`, `.zsh_plugins.txt` |
| `git/` | `.gitignore_global` (git user config is applied imperatively by `bootstrap.sh` via `git config --global`) |
| `.githooks/` | Repo-local git hooks wired via `core.hooksPath` by `bootstrap.sh`. Currently: `pre-commit` runs `gitleaks` on the staged diff. |
| `tmux/` | `.tmux.conf` and `plugins/` (includes vendored `tmux-agent-sessions` helper) |
| `neovim/` | Lua config tree (`init.lua`, `lua/config/`, `lua/plugins/`, `lsp/`) → the whole directory is symlinked to `~/.config/nvim`. Legacy `init.vim` archived under `neovim/.archive/`. |
| `starship/` | `starship.toml` → symlinked to `~/.config/starship.toml` |
| `ghostty/` | `config` → symlinked to `~/.config/ghostty/config` |
| `lldb/` | `.lldbinit` (imports chisel + DerekSelander LLDB helpers) |
| `Brewfile` | Formulae, casks, and VS Code extensions installed by `brew bundle` |

## Conventions

**Shell formatting: always `shfmt -i 2` (2-space indent).** The existing scripts follow this; preserve it. Before committing shell changes, run:

```sh
shfmt -i 2 -w <file>       # format in place
shfmt -i 2 -d <file>       # show diff without writing
```

**Shell linting: run `shellcheck` on any script you edit** and address all findings before committing. `shellcheck` is already installed via `Brewfile`.

```sh
shellcheck <file>                        # lint a single script
shellcheck bootstrap.sh make_symlinks.sh mac-os_settings.sh   # lint all top-level scripts
```

A few `# shellcheck disable=SCxxxx` directives already exist (e.g., in `bootstrap.sh` around the antidote sourcing); add new ones sparingly and always with a justification comment.

**Git config is managed by `bootstrap.sh`**, not by a checked-in `.gitconfig`. If you need a new global git setting, add a `git_set <key> <value>` line in the "Git config" block of `bootstrap.sh` — it diffs against the current value and only writes on change.

**macOS defaults are managed by `mac-os_settings.sh`**, not by a plist. Add `defaults write` lines there. The script bails early on non-Darwin and keeps a sudo keep-alive loop while running.

**`$PATH` order matters.** `.zshenv` sets `no_global_rcs` to prevent macOS's `path_helper` from reordering things; preserve that and prepend (not append) when something needs priority.

**Secret scanning.** `gitleaks` runs on every commit (via the repo-local `pre-commit` hook in `.githooks/`) and in CI (the `secret-scan` job in `.github/workflows/ci.yml`). For a false positive, bypass with `git commit --no-verify` and consider adding an entry to a `.gitleaks.toml` allowlist rather than disabling the hook. The scope is repo-local — `core.hooksPath` is set with `git config --local` by `bootstrap.sh` so no other repo on the machine is affected.

## Gotchas

- Editing `zsh/.zsh_plugins.txt` has no effect until bootstrap regenerates `~/.zsh_plugins.zsh`.
- `.zshrc` ends with `eval "$(starship init zsh)"` and `eval "$(mise activate zsh)"` — anything you add after those runs after prompt/toolchain init. The SDKMAN block has a `MUST BE AT THE END` comment but is followed by later additions; when in doubt, put new inits before the starship line.
- `make_symlinks.sh` fails fast if a source path listed in `symlinks.txt` does not exist. If you rename or delete a source file, update `symlinks.txt` in the same commit.
- `bootstrap.sh` calls `sudo -v` early and spawns a background keep-alive; scripts that invoke it from CI should pass `--yes` or set `CI=1`.
