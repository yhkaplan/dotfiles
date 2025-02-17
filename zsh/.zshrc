# Create new Tmux session if not inside one
# Using wildcards around screen because it could be screen-color256 or something
if ! { [[ "$TERM" == *"screen"* ]] && [ -n "$TMUX" ]; } then
  tmux new
fi

# Kill 2 oldest detached tmux sessions if more than 3 exist that are detached
# sessions=$(tmux list-sessions | grep -E -v '\(attached\)$')
# session_count=$(echo $sessions | wc -l | tr -d '[:space:]' || 0)
# if [$session_count -gt 3]; then
#   i=0
#   # Kill first 2 detached sessions
#   echo $sessions | while IFS='\n' read line; do
#     if [$i -lt 2]; then
#       echo "Killing ${line%%:*}"
#       # tmux kill-session -t "${line%%:*}"
#     fi
#     i=$((i+1))
#   done
# fi

source ~/.zsh_plugins.zsh
source ~/.dotfiles/zsh/aliases.zsh

# =============
#    EXPORT
# =============
export EDITOR="vim"
export LSCOLORS=cxBxhxDxfxhxhxhxhxcxcx
export CLICOLOR=1

# support colors in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# History substring
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Spaceship
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  line_sep      # Line break
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_CHAR_SYMBOL="»" # ❯ 日本語の対応
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_CHAR_PREFIX=""
SPACESHIP_GIT_PREFIX=""
SPACESHIP_GIT_BRANCH_PREFIX=""
SPACESHIP_GIT_STATUS_STASHED=""
# SPACESHIP_GIT_STATUS_PREFIX=""
# SPACESHIP_GIT_STATUS_SUFFIX=""
SPACESHIP_VI_MODE_COLOR="cyan"

autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

zmodload -i zsh/complist

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances of the shell

setopt auto_cd # cd by typing directory name if it's not a command
setopt correct_all # autocorrect commands
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match

zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.dotfiles/zsh/fzf-funcs.zsh
# Use fd for better performance, skip .git, show hidden files, and follow symlinks
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
# Instead of using TAB key with a trigger sequence (**<TAB>), you can assign a dedicated key for fuzzy completion while retaining the default behavior of TAB key.
export FZF_COMPLETION_TRIGGER=''

bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion

# Useful iOS dev funcs
source ~/.dotfiles/zsh/simctl-funcs.zsh

root() {
  git_dir="$(git rev-parse --show-toplevel 2> /dev/null)"

  if [ -z $git_dir ]
  then
    cd ..
  else
    cd "$git_dir"
  fi
}

# Add ssh keys
ssh-add -A > /dev/null 2>&1

# Envar secrets
token_path="$HOME/.secrets/tokens"
if [ -f "$token_path" ]; then
  # shellcheck source=.secrets/tokens
  source "$token_path"
fi

# Turn off autocorrect suggestions
unsetopt correct
unsetopt correct_all
export DISABLE_CORRECTION=true

# Autojump

[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
