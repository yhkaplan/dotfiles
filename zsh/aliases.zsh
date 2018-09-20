# Auto expand aliases
abbrev-alias --init

abbrev-alias -g G="| grep"
abbrev-alias -g E="2>&1 > /dev/null"
abbrev-alias -g N="> /dev/null"

# Git-related
abbrev-alias gpl='git pull'
abbrev-alias gps='git push'
abbrev-alias ga='git add -A'
abbrev-alias gc='git commit -m'
abbrev-alias gco='git checkout'
abbrev-alias gs='git status -s'
abbrev-alias gf='git fetch'
abbrev-alias gb='git branch'
abbrev-alias gm='git merge'
abbrev-alias gd='git diff -w'
abbrev-alias gv='git diff develop -w'
abbrev-alias gl='git log --oneline --since=yesterday'
abbrev-alias gsl='git log -8 --pretty --oneline'
abbrev-alias ggui='git log --graph --decorate --oneline'
abbrev-alias gclean='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'
abbrev-alias gpr='git pull-request -m'
abbrev-alias gh='git log --pretty=format:%H -1 | pbcopy'
abbrev-alias gr='git log --oneline --since=yesterday | pbcopy'

# Other
abbrev-alias be="bundle exec"
abbrev-alias ow='open *.xcworkspace/'
abbrev-alias ox='open *.xcodeproj'
abbrev-alias xs='sudo xcode-select --switch /Applications/Xcode.app'
abbrev-alias xv='xcodebuild -version'
abbrev-alias pi='bundle exec pod install'
abbrev-alias bm='xcodebuild -workspace minne.xcworkspace/ -scheme minne | xcpretty'
abbrev-alias nv='nvim'
abbrev-alias trel='tree -L 2'
abbrev-alias formatswift='swiftlint autocorrect --config .swiftlint.yml --path '
abbrev-alias pipupdate="pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U"

alias l='ls -GpF' # Mac OSX specific
alias ls='ls -GpF' # Mac OSX specific
alias ll='ls -alGpF' # Mac OSX specific
