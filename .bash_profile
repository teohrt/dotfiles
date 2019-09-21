# Sexy prompt with git branch integration
source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh

export PS1="\n⚡️teo(\e[0;36m\W\e[m)\e[1;32m\$(__git_ps1)\e[m→ "
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
alias push="git push"
alias pull="git pull"
alias gs="git status"
alias gl="git log"
alias ga="git add . ; git status"
alias gc="git commit -m "

# Misc
alias o="open ."
alias c="clear"
alias l="ls -lAhp"
alias ~="cd ~"
alias ..="cd .."
alias mkdir="mkdir -pv "
alias link="ln -s "
alias grep='grep --color=auto -i'
alias epg="printenv | grep "
alias sneak="chmod 600 " # If you're sneaky... no one can see or do anything to you.
alias ninja="chmod 700 " # Ninjas can sneak... and they are able to execute you too. 🤣
alias myip="curl http://ipecho.net/plain; echo"

mcd () {
    mkdir $1
    cd $1
}

nukeD () {
    if [ "$1" = '' ] ; then
        echo Please specify a directory
    else
        rm -ri $1*
        if [ $? -ne 0 ] ; then
            echo You can\'t delete what isn\'t there...
        fi
    fi
}

wifipwd () {
    security find-generic-password -ga "$1" | grep "password:"
}