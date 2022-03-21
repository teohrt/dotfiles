# Standard profile
# ----------------

export BASH_SILENCE_DEPRECATION_WARNING=1 # With Mac's default interactive shell now zsh, we'll want to silence the obnoxious message
source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
export PS1='🪂 \u(\[\e[0;36m\]\W\[\e[m\])\[\e[1;32m\]$(__git_ps1 " (%s)")\[\e[m\]→ '
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Python
alias python="python3"

# Meta
alias ebash="subl ~/.bash_profile"
alias rbash="source ~/.bash_profile"

# Dev Workflow
alias push="git push"
alias pull="git pull"
alias gs="clear; git status"
alias gl="git log"
alias ga="git add . ; git status"
alias gc="git commit -m "
alias gch="git checkout "
alias gh="open \`git remote -v | grep fetch | head -1 | cut -f2 | cut -d' ' -f1 | sed -e's/git@/http:\/\//' -e's/\.git$//' | sed -E 's/(\/\/[^:]*):/\1\//'\`"

greset1 () {
    echo Type \'yes\' if want to reset your git history by one commit:
    read ans
    if [ "$ans" = 'yes' ] ; then
        git log -2 | grep commit | tail -1 | awk '{print $NF}' | xargs git reset
    else
        echo Aborting.
    fi
}

scripts () {
    if [ ! -e package.json ]; then
      echo "Not a package.json in this directory"
    else
      run_command="npm run $(jq '.scripts | keys[]' package.json | sed 's/"//g' | fzf)"
      eval $run_command
    fi
}

# Preferred options
alias mv='mv -v'
alias rm='rm -i -v'
alias cp='cp -v'
alias ls="ls -Aplhtr"
alias grep="grep --ignore-case --color --line-number"
alias mkdir="mkdir -pv "

# Navigation
alias x="exit"
alias o="open ."
alias ..="cd ..; clear; ls"
alias ...="cd ../..; clear; ls"
alias ~="cd ~; clear; ls"
alias Downloads="cd ~/Downloads; clear; ls"
alias Documents="cd ~/Documents; clear; ls"
alias Dev="cd ~/Dev; clear; ls"

# Miscellaneous
alias c.="code ."
alias c="clear"
alias l="clear; ls"
alias ninja="chmod 700 "
alias sneak="chmod 600 "
alias epg="printenv | grep "
alias path='echo -e ${PATH//:/\\n}'
alias ip="ipconfig getifaddr en0"
alias mac="networksetup -getmacaddress en0"
alias m='make'
alias big10='du -a -h ./ | sort -h -r | head -n 10'

wifipwd () {
    if [ "$1" = '' ] ; then
        echo Please specify a network
    else
        security find-generic-password -ga "$1" | grep "password:"
    fi
}