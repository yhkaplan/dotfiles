# !/usr/local/bin/fish

# Reference this article for more info: 
# http://sherifsoliman.com/2016/12/29/tmux-workspace-scripts/

tmux rename-window ios-main
tmux rename-session minne
tmux send "cd ~/dev/minne/ios/" C-m

tmux split-window -h
tmux rename-session today
tmux send-keys "cd ~/Documents; nvim today/Today.md" C-m

tmux select-pane -t 0
tmux split-window -v
tmux rename-session other
