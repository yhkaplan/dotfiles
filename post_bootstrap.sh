#!/usr/local/bin/fish

curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fisher install tuvistavie/fish-ssh-agent
fisher install fzf
fisher install eden
# Runs a tmux-friendly version of fzf instead.
set -U FZF_TMUX 1
# Use fd for better performance, skip .git, show hidden files, and follow symlinks
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# requires atom commandline tools
apm install --packages-file ~/.atom/package.list
