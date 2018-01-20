# Start TMUX at launch
#if status is-interactive
#and not set -q TMUX
#    exec tmux
#end

set -g -x PATH /usr/local/bin $PATH

# Gotham Shell
#eval sh $HOME/.config/gotham/gotham.sh

# For Swift
set PATH /usr/bin/ $PATH
#set PATH /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ $PATH

# For Golang
set -x GOPATH $HOME/go/

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

