function fco -d "Fuzzy-find and checkout a branch"
  git branch | grep -v HEAD | string trim | fzf-tmux -d 10 | xargs git checkout
end

# Destructive
function fs -d "Switch tmux session"
  tmux list-sessions -F "#{session_name}" | fzf | xargs tmux switch-client -t
end

function fssh -d "Fuzzy-find ssh host and ssh into it"
  ag '^host [^*]' ~/.ssh/config | cut -d ' ' -f 2 | fzf | xargs -o ssh
end

function fcd -d "Fuzzy change directory"
  if set -q argv[1]
      set searchdir $argv[1]
  else
      set searchdir $HOME
  end

  # https://github.com/fish-shell/fish-shell/issues/1362
  set -l tmpfile (mktemp)
  find $searchdir \( ! -regex '.*/\..*' \) ! -name __pycache__ -type d | fzf > $tmpfile
  set -l destdir (cat $tmpfile)
  rm -f $tmpfile

  if test -z "$destdir"
      return 1
  end

  cd $destdir
end

function bcd -d 'cd to one of the previously visited locations'
  # Clear non-existent folders from cdhist.
  set -l buf
  for i in (seq 1 (count $dirprev))
  	set -l dir $dirprev[$i]
  	if test -d $dir
  		set buf $buf $dir
  	end
  end
  set dirprev $buf
  string join \n $dirprev | tail -r | sed 1d | eval (__fzfcmd) +m --tiebreak=index --toggle-sort=ctrl-r $FZF_CDHIST_OPTS | read -l result
  [ "$result" ]; and cd $result
  commandline -f repaint
end

function vi -d "Open file in Neovim"
  # https://github.com/fish-shell/fish-shell/issues/1362
  set -l tmpfile (mktemp)
  find . -type f | fzf > $tmpfile
  set -l destfile (cat $tmpfile)
  rm -f $tmpfile

  if test -z "$destfile"
      return 1
  end

  nvim $destfile
end

function __ghq_cd_repository -d "Change local repository directory"
  ghq list --full-path | fzf | read -l repo_path
  builtin cd $repo_path
  commandline -f repaint
end

function __ghq_browse_github -d "Browse remote repository on github"
  ghq list | fzf | read -l repo_path
  set -l repo_name (string split -m1 "/" $repo_path)[2]
  hub browse $repo_name
end

alias ghb __ghq_browse_github
