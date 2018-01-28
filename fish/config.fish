# Start TMUX at launch
#if status is-interactive
#and not set -q TMUX
#    exec tmux
#end

# Sets path for things installed w/ Homebrew
set -g -x PATH /usr/local/bin $PATH

# For Swift
set PATH /usr/bin/ $PATH
#set PATH /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ $PATH

# For Golang
set -x GOPATH $HOME/go
set -x GOROOT /usr/local/opt/go/libexec
set -g -x PATH $GOPATH/bin $PATH
set -g -x PATH $GOROOT/bin $PATH

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

