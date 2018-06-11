#!/usr/local/bin/fish

curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fisher install tuvistavie/fish-ssh-agent
fisher install fzf
fisher install eden
# Runs a tmux-friendly version of fzf instead.
set -U FZF_TMUX 1

# requires atom commandline tools
apm install --packages-file ~/.atom/package.list
