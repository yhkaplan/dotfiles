# dotfiles

My personal dotfiles for working with a variety of language ecosystems on macOS. Primary tools are Ghostty, Neovim, Tmux, and Zsh with some nice plugins.

## Setup

On a fresh (or not-so-fresh) macOS machine:

```
git clone <this-repo> ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

All three setup scripts are idempotent — re-running is safe.

### bootstrap.sh

End-to-end provisioning. Installs Homebrew, runs `brew bundle`, sets up zsh
plugins, clones vendored helpers (tpm, DerekSelander's LLDB), configures git,
creates symlinks, and applies macOS settings.

```
./bootstrap.sh [flags]

  --yes / -y        non-interactive (also honored if CI=1)
  --skip-brew       skip Homebrew install/upgrade and Brewfile
  --skip-symlinks   don't run make_symlinks.sh
  --skip-macos      don't run mac-os_settings.sh
  --restart-apps    forward to mac-os_settings.sh (kills Finder, Dock, etc)
```

### make_symlinks.sh

Creates the symlinks listed in `symlinks.txt`. Lines are
`<source> <destination>`; a trailing `/` on the destination means "into that
directory"; otherwise the destination is the full link path. Skips links that
are already correct; real conflicts are moved to
`~/.old_dotfiles/<timestamp>/`.

### mac-os_settings.sh

Applies `defaults write` preferences. Pass `--restart-apps` to kill
Finder/Dock/etc immediately; otherwise changes take effect on next
logout/restart or app relaunch.

## Work-machine extras

Create `~/.dotfiles/work_machine_setup.env` (gitignored) with any
work-only env vars. It's sourced by `zsh/.zshenv` when present.
