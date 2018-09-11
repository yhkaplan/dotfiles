# rbenv
export PATH="${HOME}/.rbenv/shims:${PATH}"
eval "$(rbenv init - zsh)"
# for swiftenv
export SWIFTENV_ROOT="$HOME/.swiftenv"
export PATH="$SWIFTENV_ROOT/bin:$PATH"
eval "$(swiftenv init -)"

# Sets path for things installed w/ Homebrew
export PATH="$PATH:/usr/local/bin"

# Set path for scripts
export PATH="$PATH:${HOME}/.dotfiles/scripts"

# For Swift
export PATH="$PATH:/usr/bin/"

# For Golang
export GOPATH="$HOME/go"
export GOROOT="/usr/local/opt/go/libexec"
export PATH="${PATH}:${GOROOT}/bin:${GOPATH}/bin"

export MYVIMRC="$HOME/.config/nvim/init.vim"
