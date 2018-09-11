# rbenv
export PATH="${HOME}/.rbenv/shims:${PATH}"
eval "$(rbenv init - zsh)"

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
