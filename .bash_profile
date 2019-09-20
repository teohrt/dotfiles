# Clean prompt
export PS1="\n⚡️teo(\W\[$(tput sgr0)\])→ "
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

alias goapp="cd $GOPATH/src"

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
alias ~="cd ~"
alias ..="cd .."
alias mkdir="mkdir -pv "
alias link="ln -s "
alias epg="printenv | grep -i "
alias sneak="chmod 600 " # If you're sneaky... no one can see or do anything to you.
alias ninja="chmod 700 " # Ninjas can sneak... and they are able to execute you too. 🤣
alias myip="curl http://ipecho.net/plain; echo"

mcd () {
    mkdir $1
    cd $1
}