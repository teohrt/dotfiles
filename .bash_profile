# Standard profile
# ----------------

# With Mac's default interactive shell now zsh, we'll want to silence the obnoxious message
export BASH_SILENCE_DEPRECATION_WARNING=1

# Shell Personality
source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
export PS1='🪂 \u(\[\e[0;36m\]\W\[\e[m\])\[\e[1;32m\]$(__git_ps1 " (%s)")\[\e[m\]→ '
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Replaces fzf grep with ripgrep when STDIN pipe isn't provided - makes fzf faster
export FZF_DEFAULT_COMMAND='rg --files --hidden --no-require-git --follow --glob "!.git/*"'

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# JavaScript
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Python
alias python="python3"

# Meta
alias ebash="subl ~/.bash_profile"
alias rbash="source ~/.bash_profile"

# Dev
alias push="git push"
alias pushF="git push --force"
alias pull="git pull"
alias stash="git stash --include-untracked"
alias pop="git stash pop"
alias gs="clear; git status"
alias gl="git log"
alias ga="git add . ; git status"
alias gc="git commit -m "
alias gh="open \`git remote -v | grep fetch | head -1 | cut -f2 | cut -d' ' -f1 | sed -e's/git@/http:\/\//' -e's/\.git$//' | sed -E 's/(\/\/[^:]*):/\1\//'\`"
alias gchB="git checkout -B"

gbD () { # git branch delete with fuzzy matching
  local branches branchInfo branchName
  branches=$(git --no-pager branch -vv) &&
  branchInfo=$(echo "$branches" | fzf +m) && 
  branchName=$(echo "$branchInfo" | awk '{print $1}' | sed "s/.* //")

  echo Type \'yes\' if you want to delete "$branchName"
  read ans
  if [ "$ans" = 'yes' ] ; then
    git branch -D $(echo "$branchName")
  else
      echo Aborting.
  fi
}

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

ys () { # select and run a package.json script THROUGH YARN with fuzzy matching
    local script
    if [ ! -e package.json ]; then
      echo No package.json in this directory
    else
      script=$(jq '.scripts | keys[]' package.json | sed 's/"//g' | fzf)
      yarn run $script
    fi
}

ns () { # select and run a package.json script THROUGH NPM with fuzzy matching
    local script
    if [ ! -e package.json ]; then
      echo No package.json in this directory
    else
      script=$(jq '.scripts | keys[]' package.json | sed 's/"//g' | fzf)
      npm run $script
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
      echo Network: $network
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