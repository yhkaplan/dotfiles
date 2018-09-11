source ~/.zsh_plugins.sh
source ~/.dotfiles/zsh/aliases.zsh
source "$HOME/.zshenv"
# Sets path for things installed w/ Homebrew
export PATH="$PATH:/usr/local/bin"
# Set path for scripts
export PATH="$PATH:$HOME/.dotfiles/scripts"

export MYVIMRC="$HOME/.config/nvim/init.vim"
# For Swift
export PATH="$PATH:/usr/bin/"

# For Golang
export GOPATH="$HOME/go"
export GOROOT="/usr/local/opt/go/libexec"
export PATH=$GOPATH/bin:$PATH
export PATH=$GOROOT/bin:$PATH

# History substring
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Shaceship
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_GIT_PREFIX=""
SPACESHIP_GIT_BRANCH_PREFIX=""
SPACESHIP_GIT_STATUS_STASHED=""

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
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
# Instead of using TAB key with a trigger sequence (**<TAB>), you can assign a dedicated key for fuzzy completion while retaining the default behavior of TAB key.
export FZF_COMPLETION_TRIGGER=''
bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
