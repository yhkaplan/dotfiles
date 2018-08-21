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
