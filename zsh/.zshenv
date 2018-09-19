# Tell macOS not to call pathhelper (/usr/libexec/path_helper),
# which overrides PATH after this is called
setopt no_global_rcs

# Add commonly used folders to $PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Set path for scripts
export PATH="$PATH:${HOME}/.dotfiles/scripts"

# go
export GOPATH="$HOME/go"
export GOROOT="/usr/local/opt/go/libexec"
export PATH="${PATH}:${GOROOT}/bin:${GOPATH}/bin"

# neovim
export MYVIMRC="$HOME/.config/nvim/init.vim"

# rbenv
export PATH="${HOME}/.rbenv/shims:${PATH}"
eval "$(rbenv init - zsh)"

# swiftenv
export SWIFTENV_ROOT="$HOME/.swiftenv"
export PATH="$SWIFTENV_ROOT/bin:$PATH"
eval "$(swiftenv init -)"
