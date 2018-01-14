set -g -x PATH /usr/local/bin $PATH

# Gotham Shell
eval sh $HOME/.config/gotham/gotham.sh

# For Golang
set -xg GOPATH $HOME/go
