function tnv
    set current_dir (pwd)
    tmux new-window
    cd current_dir
    fzf-tmux | xargs -o nvim
end
