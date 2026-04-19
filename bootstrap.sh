#!/usr/bin/env bash
# Bootstrap a fresh macOS machine (or re-provision an existing one).
# Safe to re-run: every step guards against its own prior success.
#
# Usage:
#   ./bootstrap.sh [--yes] [--skip-brew] [--skip-symlinks] [--skip-macos] [--skip-chsh] [--restart-apps]
#
# Flags:
#   --yes / -y        Non-interactive; assume yes to prompts (also honored if CI=1)
#   --skip-brew       Don't install or update Homebrew packages
#   --skip-symlinks   Don't run make_symlinks.sh
#   --skip-macos      Don't run mac-os_settings.sh
#   --skip-chsh       Don't change the default shell (useful in CI)
#   --restart-apps    Passed through to mac-os_settings.sh

set -Eeuo pipefail

#### Flags ####

YES=${CI:+1}
YES="${YES:-0}"
SKIP_BREW=0
SKIP_SYMLINKS=0
SKIP_MACOS=0
SKIP_CHSH=0
RESTART_APPS=0

while [[ $# -gt 0 ]]; do
  case "$1" in
  -y | --yes) YES=1 ;;
  --skip-brew) SKIP_BREW=1 ;;
  --skip-symlinks) SKIP_SYMLINKS=1 ;;
  --skip-macos) SKIP_MACOS=1 ;;
  --skip-chsh) SKIP_CHSH=1 ;;
  --restart-apps) RESTART_APPS=1 ;;
  -h | --help)
    sed -n '2,15p' "$0"
    exit 0
    ;;
  *)
    echo "unknown flag: $1" >&2
    exit 1
    ;;
  esac
  shift
done

DOTFILES_DIR="$HOME/.dotfiles"
cd "$DOTFILES_DIR"

#### Helpers ####

confirm() {
  # confirm "prompt" -> 0 if yes, 1 if no. --yes skips prompts.
  local prompt="$1"
  if ((YES)); then
    return 0
  fi
  local reply
  while true; do
    read -r -p "$prompt [y/n] " reply
    case "$reply" in
    [Yy]*) return 0 ;;
    [Nn]*) return 1 ;;
    *) echo "Please input yes or no" ;;
    esac
  done
}

info() { printf '\n==> %s\n' "$*"; }

#### Sudo keep-alive ####

sudo -v

SUDO_PID=""
cleanup() {
  [[ -n "$SUDO_PID" ]] && kill "$SUDO_PID" 2>/dev/null || true
}
trap cleanup EXIT

(
  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" 2>/dev/null || exit
  done
) 2>/dev/null &
SUDO_PID=$!

echo "Starting bootstrapping"

############ Xcode Command Line Tools ###############

ensure_xcode_clt() {
  if ! xcode-select -p >/dev/null 2>&1; then
    echo "Xcode Command Line Tools not installed." >&2
    echo "Run: xcode-select --install" >&2
    echo "Then re-run this script." >&2
    exit 1
  fi
}

info "Checking Xcode Command Line Tools"
ensure_xcode_clt

############ Homebrew ###############

BREW=""
find_brew() {
  if command -v brew >/dev/null 2>&1; then
    BREW="$(command -v brew)"
  elif [[ -x /opt/homebrew/bin/brew ]]; then
    BREW=/opt/homebrew/bin/brew
  elif [[ -x /usr/local/bin/brew ]]; then
    BREW=/usr/local/bin/brew
  fi
}

find_brew

if [[ -z "$BREW" ]]; then
  info "Installing Homebrew"
  NONINTERACTIVE=1 /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  find_brew
fi

if [[ -z "$BREW" ]]; then
  echo "brew not found after install attempt" >&2
  exit 1
fi

BREW_PREFIX="$("$BREW" --prefix)"
eval "$("$BREW" shellenv)"

if ((SKIP_BREW == 0)); then
  if confirm "Install/update brew packages from Brewfile?"; then
    info "Updating Homebrew"
    "$BREW" update
    "$BREW" upgrade

    info "Installing packages from Brewfile"
    "$BREW" bundle --file="$DOTFILES_DIR/Brewfile"
    "$BREW" cleanup
  fi
fi

############ External repos (LLDB helpers, tpm) ###############

info "Ensuring LLDB helper repo"
if [[ ! -d "$HOME/.lldb/LLDB" ]]; then
  mkdir -p "$HOME/.lldb"
  git clone https://github.com/DerekSelander/LLDB.git "$HOME/.lldb/LLDB"
else
  echo "✓ ~/.lldb/LLDB already present"
fi

info "Ensuring tmux plugin manager (tpm)"
mkdir -p "$HOME/.tmux/plugins"
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
  echo "✓ tpm already present"
fi

############ Zsh plugins via antidote ###############

ANTIDOTE_SH="$BREW_PREFIX/opt/antidote/share/antidote/antidote.zsh"
if [[ -f "$ANTIDOTE_SH" ]]; then
  info "Generating zsh plugin bundle"
  # antidote bundle uses zsh; shellcheck can't follow the sourced file.
  # shellcheck disable=SC1090
  zsh -c "source '$ANTIDOTE_SH' && antidote bundle <'$DOTFILES_DIR/zsh/.zsh_plugins.txt' >'$HOME/.zsh_plugins.zsh'"
else
  echo "antidote not installed (expected at $ANTIDOTE_SH) — skipping plugin bundle"
fi

############ Misc ###############

# Silence the "Last login:" banner
[[ -f "$HOME/.hushlogin" ]] || touch "$HOME/.hushlogin"

############ Git config ###############

info "Configuring git (idempotent)"
git_set() {
  # git_set <key> <value>
  local key="$1" value="$2"
  local current
  current="$(git config --global --get "$key" 2>/dev/null || true)"
  if [[ "$current" != "$value" ]]; then
    git config --global "$key" "$value"
    echo "  set $key = $value"
  fi
}

git_set alias.amend 'commit --amend --no-edit'
git_set init.defaultBranch main
git_set core.excludesfile "$HOME/.gitignore_global"
git_set pull.rebase false
git_set push.autoSetupRemote true
git_set core.pager "delta --dark"
git_set ghq.root "$HOME/dev"

############ Symlinks ###############

if ((SKIP_SYMLINKS == 0)); then
  info "Creating symlinks"
  "$DOTFILES_DIR/make_symlinks.sh"
fi

############ Register homebrew shells ###############

register_shell() {
  local shell_path="$1"
  if [[ ! -x "$shell_path" ]]; then
    echo "  $shell_path not found — skipping"
    return
  fi
  if grep -qxF "$shell_path" /etc/shells; then
    echo "  $shell_path already in /etc/shells"
  else
    echo "  adding $shell_path to /etc/shells"
    echo "$shell_path" | sudo tee -a /etc/shells >/dev/null
  fi
}

info "Registering homebrew shells in /etc/shells"
register_shell "$BREW_PREFIX/bin/bash"
register_shell "$BREW_PREFIX/bin/zsh"

############ Default shell ###############

HOMEBREW_ZSH="$BREW_PREFIX/bin/zsh"
if ((SKIP_CHSH == 0)) && [[ -x "$HOMEBREW_ZSH" && "$SHELL" != "$HOMEBREW_ZSH" ]]; then
  if confirm "Set $HOMEBREW_ZSH as your default shell?"; then
    chsh -s "$HOMEBREW_ZSH"
  fi
else
  echo "✓ default shell already homebrew zsh (or chsh skipped)"
fi

############ macOS settings ###############

if ((SKIP_MACOS == 0)); then
  info "Applying macOS settings"
  args=()
  ((RESTART_APPS)) && args+=(--restart-apps)
  # ${args[@]+"${args[@]}"} is the bash-3.2-safe form for expanding a
  # possibly-empty array under `set -u`; CI uses system /bin/bash (3.2).
  "$DOTFILES_DIR/mac-os_settings.sh" ${args[@]+"${args[@]}"}
fi

############ Final notes ###############

cat <<'EOF'

Bootstrapping complete.

Reminders:
  - Update hosts file with contents of
      https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
  - Restart your terminal (or log out/in) for shell and macOS changes
    to take full effect.
EOF
