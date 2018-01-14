# Start TMUX at launch
if status is-interactive
and not set -q TMUX
    exec tmux
end

set -g -x PATH /usr/local/bin $PATH

# Gotham Shell
eval sh $HOME/.config/gotham/gotham.sh

# For Golang
set -xg GOPATH $HOME/go
