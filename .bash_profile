# Standard profile
# ----------------
 
# M1 Mac Brew pathing
eval "$(/opt/homebrew/bin/brew shellenv)"

# M1 Mac docker
DOCKER_DEFAULT_PLATFORM="linux/amd64"

# With Mac's default interactive shell now zsh, we'll want to silence the obnoxious message
export BASH_SILENCE_DEPRECATION_WARNING=1

# Shell Personality
source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
# export PS1='🪂 \u(\[\e[0;36m\]\W\[\e[m\])\[\e[1;32m\]$(__git_ps1 " (%s)")\[\e[m\]→ '
export PS1='\[\]🪂 \u(\[\e[0;36m\]\W\[\e[m\])\[\e[1;32m\]$(__git_ps1 " (%s)")\[\e[m\]→ '
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Replaces fzf grep with ripgrep when STDIN pipe isn't provided - makes fzf faster
export FZF_DEFAULT_COMMAND='rg --files --hidden --no-require-git --follow --glob "!.git/*"'

# Python
eval "$(pyenv init --path)"
alias activate="source .venv/bin/activate"

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# JavaScript
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Meta
alias ebash="code ~/.bash_profile"
alias rbash="source ~/.bash_profile"

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

fhistory() { # Fuzzy match shell history search and evaluation
  local cmd
  cmd=$(history | cut -c 8- | fzf)
  echo "$cmd"
  eval "$cmd"
}

# Miscellaneous
alias v.="nvim"
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
alias big10="du -a -h ./ | sort -h -r | head -n 10" # show 10 largest files/dirs in current directory

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