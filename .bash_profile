# Clean prompt
export PS1="\n⚡️teo(\W\[$(tput sgr0)\])→ "
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Meta
alias ebash="subl ~/.bash_profile"
alias rbash="source ~/.bash_profile"

# Git
alias gs="git status"
alias gl="git log"
alias ga="git add . ; git status"
alias push="git push"
alias pull="git pull"

# Misc
alias o="open ."
alias c="clear"
alias l="ls -lAhp"
alias ..="cd .."
alias epg="printenv | grep -i "
alias goapp="cd $GOPATH/src"