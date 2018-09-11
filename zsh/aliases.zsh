# Git-related
alias gpl='git pull'
alias gps='git push'
alias ga='git add -A'
alias gc='git commit -m'
alias gco='git checkout'
alias gs='git status -s'
alias gf='git fetch'
alias gb='git branch'
alias gm='git merge'
alias gd='git diff -w'
alias gv='git diff develop -w'
alias gl='git log --oneline --since=yesterday'
alias gsl='git log -8 --pretty --oneline'
alias ggui='git log --graph --decorate --oneline'
alias gclean='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'
alias gpr='git pull-request -m'
alias gh='git log --pretty=format:%H -1 | pbcopy'

# Other
alias ow='open *.xcworkspace/'
alias ox='open *.xcodeproj'
alias pi='bundle exec pod install'
alias bm='xcodebuild -workspace minne.xcworkspace/ -scheme minne | xcpretty'
alias nv='nvim'
alias trel='tree -L 2'
alias formatswift='swiftlint autocorrect --config .swiftlint.yml --path '
alias pipupdate='pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U'
alias l='ls -GpF' # Mac OSX specific
alias ls='ls -GpF' # Mac OSX specific
alias ll='ls -alGpF' # Mac OSX specific
