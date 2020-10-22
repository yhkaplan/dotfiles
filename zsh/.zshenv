# Tell macOS not to call pathhelper (/usr/libexec/path_helper),
# which overrides PATH after this is called
setopt no_global_rcs

# Fastlane requires some environment variables set up to run correctly.
# In particular, having your locale not set to a UTF-8 locale will cause
# issues with building and uploading your build
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Add commonly used folders to $PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Set path for scripts
export PATH="$PATH:${HOME}/.dotfiles/scripts"

# Go
export GOPATH="$HOME/go"
export GOROOT="/usr/local/opt/go/libexec"
export PATH="${PATH}:${GOROOT}/bin:${GOPATH}/bin"

# Flutter
export PATH="${PATH}:${HOME}/flutter/bin"

# Set a default simulator for iOS
export DEFAULT_SIM="platform=iOS Simulator,name=iPhone 8,OS=12.0"

# neovim
export MYVIMRC="$HOME/.config/nvim/init.vim"

# rbenv
export PATH="${HOME}/.rbenv/shims:${PATH}"
eval "$(rbenv init - zsh)"

# Make fastlane ...faster
export FASTLANE_SKIP_UPDATE_CHECK=TRUE

# swiftenv
export SWIFTENV_ROOT="$HOME/.swiftenv"
export PATH="$SWIFTENV_ROOT/bin:$PATH"
eval "$(swiftenv init -)"

# Direnv
eval "$(direnv hook zsh)"
