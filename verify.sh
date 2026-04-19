#!/usr/bin/env bash
# Post-condition checks for bootstrap.sh. Safe to run anytime.
#
# Asserts that a successful bootstrap run left the expected state behind:
# symlinks point where they should, external repos are cloned, git config
# is applied, homebrew shells are registered, macOS defaults are set.
#
# Exits 0 if every check passes, non-zero otherwise. All checks run even
# if earlier ones fail, so you see the full picture in one shot.

set -uo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
SYMLINKS_FILE="${SYMLINKS_FILE:-$DOTFILES_DIR/symlinks.txt}"

# Output style is chosen automatically:
#   - GITHUB_ACTIONS=true  → workflow commands (::group::, ::error::), no color
#   - interactive TTY      → colored ✓/✗/- + bold headers
#   - piped/redirected     → plain text, no color
#
# Set ci_meta immediately before a bad() call to attach file/line context
# for the emitted ::error:: annotation.
ci_mode=0
[[ "${GITHUB_ACTIONS:-}" == "true" ]] && ci_mode=1
ci_meta=""

use_color=0
if ((ci_mode == 0)) && [[ -t 1 ]] && [[ -z "${NO_COLOR:-}" ]]; then
  use_color=1
fi

if ((use_color)); then
  C_GREEN=$'\e[32m'
  C_RED=$'\e[31m'
  C_DIM=$'\e[2m'
  C_BOLD=$'\e[1m'
  C_RESET=$'\e[0m'
else
  C_GREEN="" C_RED="" C_DIM="" C_BOLD="" C_RESET=""
fi

# In CI each section is wrapped in ::group::/::endgroup:: so logs are foldable.
in_group=0

locate_in_file() {
  # locate_in_file <file-under-DOTFILES_DIR> <grep-regex>
  # prints "file=FILE,line=N" (or "file=FILE" if pattern not found).
  local file="$1" pattern="$2" line
  line="$(grep -nE "$pattern" "$DOTFILES_DIR/$file" 2>/dev/null | head -1 | cut -d: -f1)"
  if [[ -n "$line" ]]; then
    printf 'file=%s,line=%s' "$file" "$line"
  else
    printf 'file=%s' "$file"
  fi
}

pass=0
fail=0
skip=0

ok() {
  printf '  %s✓%s %s\n' "$C_GREEN" "$C_RESET" "$*"
  pass=$((pass + 1))
}
bad() {
  local msg="$*"
  printf '  %s✗%s %s\n' "$C_RED" "$C_RESET" "$msg" >&2
  if ((ci_mode)); then
    if [[ -n "$ci_meta" ]]; then
      printf '::error %s::%s\n' "$ci_meta" "$msg"
    else
      printf '::error::%s\n' "$msg"
    fi
  fi
  fail=$((fail + 1))
  ci_meta=""
}
note() {
  printf '  %s- %s%s\n' "$C_DIM" "$*" "$C_RESET"
  skip=$((skip + 1))
}
section() {
  if ((ci_mode)); then
    ((in_group)) && printf '::endgroup::\n'
    printf '::group::%s\n' "$*"
    in_group=1
  else
    printf '\n%s== %s ==%s\n' "$C_BOLD" "$*" "$C_RESET"
  fi
}

expand_tilde() { printf '%s' "${1/#\~/$HOME}"; }

#### Symlinks ####

section "symlinks"
if [[ ! -f "$SYMLINKS_FILE" ]]; then
  ci_meta="file=symlinks.txt"
  bad "symlinks file not found: $SYMLINKS_FILE"
else
  lineno=0
  while IFS= read -r line || [[ -n "$line" ]]; do
    lineno=$((lineno + 1))
    [[ -z "${line// /}" || "$line" =~ ^[[:space:]]*# ]] && continue
    read -r raw_src raw_dst <<<"$line"
    if [[ -z "${raw_src:-}" || -z "${raw_dst:-}" ]]; then
      ci_meta="file=symlinks.txt,line=$lineno"
      bad "malformed entry in symlinks.txt: $line"
      continue
    fi

    src="$(expand_tilde "$raw_src")"
    dst="$(expand_tilde "$raw_dst")"
    if [[ "$dst" == */ ]]; then
      target="${dst%/}/$(basename "$src")"
    else
      target="$dst"
    fi

    if [[ -L "$target" && "$(readlink "$target")" == "$src" ]]; then
      ok "$target → $src"
    else
      ci_meta="file=symlinks.txt,line=$lineno"
      bad "$target does not link to $src (got: $(readlink "$target" 2>/dev/null || echo '<not a symlink>'))"
    fi
  done <"$SYMLINKS_FILE"
fi

#### External repos ####

section "external repos"
for repo in "$HOME/.lldb/LLDB" "$HOME/.tmux/plugins/tpm"; do
  if [[ -d "$repo/.git" ]]; then
    ok "$repo cloned"
  else
    ci_meta="$(locate_in_file bootstrap.sh "git clone .*$(basename "$repo")")"
    bad "$repo missing or not a git repo"
  fi
done

#### Generated files ####

section "generated files"
if [[ -f "$HOME/.hushlogin" ]]; then
  ok "$HOME/.hushlogin exists"
else
  ci_meta="$(locate_in_file bootstrap.sh 'hushlogin')"
  bad "$HOME/.hushlogin missing"
fi

if command -v brew >/dev/null 2>&1 \
  && [[ -f "$(brew --prefix)/opt/antidote/share/antidote/antidote.zsh" ]]; then
  if [[ -f "$HOME/.zsh_plugins.zsh" ]]; then
    ok "$HOME/.zsh_plugins.zsh generated"
  else
    ci_meta="$(locate_in_file bootstrap.sh 'zsh_plugins')"
    bad "$HOME/.zsh_plugins.zsh missing (antidote is installed)"
  fi
else
  note "$HOME/.zsh_plugins.zsh check skipped (antidote not installed)"
fi

#### Git config ####

section "git config"
check_git_config() {
  local key="$1" expected="$2"
  local current
  current="$(git config --global --get "$key" 2>/dev/null || true)"
  if [[ "$current" == "$expected" ]]; then
    ok "git $key = $expected"
  else
    ci_meta="$(locate_in_file bootstrap.sh "git_set $key")"
    bad "git $key: expected '$expected', got '$current'"
  fi
}
check_git_config init.defaultBranch main
check_git_config core.excludesfile "$HOME/.gitignore_global"
check_git_config push.autoSetupRemote true
check_git_config pull.rebase false

#### /etc/shells ####

section "/etc/shells"
if command -v brew >/dev/null 2>&1; then
  brew_prefix="$(brew --prefix)"
  for shell in "$brew_prefix/bin/zsh" "$brew_prefix/bin/bash"; do
    if [[ ! -x "$shell" ]]; then
      note "$shell not installed (skipping registration check)"
      continue
    fi
    if grep -qxF "$shell" /etc/shells; then
      ok "$shell registered in /etc/shells"
    else
      ci_meta="$(locate_in_file bootstrap.sh 'register_shell')"
      bad "$shell not in /etc/shells"
    fi
  done
else
  note "/etc/shells check skipped (brew missing)"
fi

#### macOS defaults ####

section "macOS defaults"
if [[ "$(uname -s)" != "Darwin" ]]; then
  note "defaults check skipped (not macOS)"
else
  check_default() {
    local domain="$1" key="$2" expected="$3"
    local current
    current="$(defaults read "$domain" "$key" 2>/dev/null || true)"
    if [[ "$current" == "$expected" ]]; then
      ok "$domain $key = $expected"
    else
      ci_meta="$(locate_in_file mac-os_settings.sh "defaults write $domain $key")"
      bad "$domain $key: expected '$expected', got '$current'"
    fi
  }
  check_default com.apple.finder ShowPathbar 1
  check_default com.apple.finder AppleShowAllFiles 1
  check_default com.apple.dock show-recents 0
  check_default com.apple.menuextra.battery ShowPercent YES
fi

#### Summary ####

# Close the final CI group before printing the summary so it renders
# outside (and thus stays expanded/visible in the Actions log).
((ci_mode && in_group)) && printf '::endgroup::\n'

if ((fail > 0)); then
  summary_color="$C_RED"
else
  summary_color="$C_GREEN"
fi
printf '\n%s== summary ==%s\n' "$C_BOLD" "$C_RESET"
printf '  %s%d passed, %d failed, %d skipped%s\n' \
  "$summary_color" "$pass" "$fail" "$skip" "$C_RESET"
exit $((fail > 0 ? 1 : 0))
