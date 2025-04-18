# Tell macOS not to call pathhelper (/usr/libexec/path_helper),
# which overrides PATH after this is called
setopt no_global_rcs

# Fastlane requires some environment variables set up to run correctly.
# In particular, having your locale not set to a UTF-8 locale will cause
# issues with building and uploading your build
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Add commonly used folders to $PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Set path for scripts
export PATH="$PATH:${HOME}/.dotfiles/scripts"

# Go
export GOPATH="$HOME/dev"
export PATH="${PATH}:${GOROOT}/bin:${GOPATH}/bin"

# Set a default simulator for iOS
export DEFAULT_SIM="platform=iOS Simulator,name=iPhone 8,OS=12.0"

# neovim
export MYVIMRC="$HOME/.config/nvim/init.vim"

# rbenv
export PATH="${HOME}/.rbenv/shims:${PATH}"
eval "$(rbenv init - zsh)"

# Make fastlane ...faster
export FASTLANE_SKIP_UPDATE_CHECK=TRUE

# Direnv
eval "$(direnv hook zsh)"

# Nodenv
if [ -x "$(command -v nodenv)" ]; then
  eval "$(nodenv init -)"
fi 

# Rust
. "$HOME/.cargo/env"
