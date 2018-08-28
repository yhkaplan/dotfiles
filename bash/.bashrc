# shellcheck source=~/.fzf.bash
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\h:\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
  shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew > /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
  source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
  complete -o default -o nospace -F _git g;
fi;

# Required for Fastlane
PATH="$HOME/.fastlane/bin:$PATH"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Aliases
alias ls='ls -GFh'
alias tr='tree -L 2'
# This is needed for ctags + Vim integration
alias ctags="`brew --prefix`/bin/ctags"

# FZF
# Use fd for better performance, skip .git, show hidden files, and follow symlinks
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude **.storyboard'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Golang
# GoRoot path for Homebrew/macOS
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Rbenv support
eval "$(rbenv init -)"

# Swiftenv
if which swiftenv > /dev/null; then eval "$(swiftenv init -)"; fi

# Envar secrets
token_path="$HOME/.secrets/tokens"
if [ -f "$token_path" ]; then
  # shellcheck source=.secrets/tokens
  source "$token_path"
fi
