function fco -d "Fuzzy-find and checkout a branch"
  git branch | grep -v HEAD | string trim | fzf-tmux -d 10 | xargs git checkout
end
