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

# Dev
alias push="git push"
alias pull="git pull"
alias gs="clear; git status"
alias gl="git log"
alias ga="git add . ; git status"
alias gc="git commit -m "
alias gh="open \`git remote -v | grep fetch | head -1 | cut -f2 | cut -d' ' -f1 | sed -e's/git@/http:\/\//' -e's/\.git$//' | sed -E 's/(\/\/[^:]*):/\1\//'\`"

gch () { # checkout git branch with fuzzy matching
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

greset1 () {
    echo Type \'yes\' if you want to reset your git history by one commit:
    read ans
    if [ "$ans" = 'yes' ] ; then
        git log -2 | grep commit | tail -1 | awk '{print $NF}' | xargs git reset
    else
        echo Aborting.
    fi
}

fscript () { # select and run a package.json script with fuzzy matching
    if [ ! -e package.json ]; then
      echo No package.json in this directory
    else
      npm run $(jq '.scripts | keys[]' package.json | sed 's/"//g' | fzf)
      clear
    fi
}

# Preferred options
alias mv="mv -v"
alias rm="rm -i -v"
alias cp="cp -v"
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

fd() { # Fuzzy match directory navigation
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m)
  cd "$dir"
}

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
alias m="make"
alias big10="du -a -h ./ | sort -h -r | head -n 10"

wifipwd () { # Retrieve wifi password - fuzzy match SSIDs if none is provided
    local network
    network=$1
    if [ "$network" = "" ] ; then
      network=$(networksetup -listpreferredwirelessnetworks en0 | awk '{$1=$1};1' | fzf)
    fi
    if [ "$network" != "" ] ; then # network could still be empty if fzf was exited
      security find-generic-password -ga "$network" | grep "password:"
    fi
}

fkill () { # Fuzzy matching process murder
  local process pid
  process=$(ps -ef | sed 1d | fzf -m)
  if [ "$process" != "" ] ; then
    pid=$(echo "$process" | awk '{print $2}')
    echo $pid | xargs kill -${1:-9}
    echo $process
  fi
}

emoji () { # Fuzzy match emoji printing
  local emojis selected_emoji
  emojis=$(curl -sSL 'https://git.io/JXXO7')
  selected_emoji=$(echo "$emojis" | fzf)
  echo $selected_emoji
}