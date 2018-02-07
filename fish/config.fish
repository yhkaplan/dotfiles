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

# For iTerm2
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

############# ABBREVIATIONS #################

if status --is-interactive
    set -g fish_user_abbreviations
    
    # Git-related abbreviations
    abbr -a gpl git pull
    abbr -a gps git push
    abbr -a ga git add -A
    abbr -a gc git commit -m "
    abbr -a gco git checkout
    abbr -a gs git status -s
    abbr -a gf git fetch
    abbr -a gb git branch
    abbr -a gm git merge
    abbr -a gd git diff
    abbr -a gl git log -1 HEAD
    abbr -a gsl git log -8 --pretty --oneline
    abbr -a ggui git log --graph --decorate --oneline
    abbr -a gdel git branch -d
    abbr -a gclean git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d

    # Other abbreviations
    abbr -a ow open *.xcworkspace/
    abbr -a nv nvim
    abbr -a trel tree -L 2

end
