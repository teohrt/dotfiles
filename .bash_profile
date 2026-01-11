# Standard profile
# ----------------
 
# M1 Mac Brew pathing
eval "$(/opt/homebrew/bin/brew shellenv)"

# M1 Mac docker
DOCKER_DEFAULT_PLATFORM="linux/amd64"

# With Mac's default interactive shell now zsh, we'll want to silence the obnoxious message
export BASH_SILENCE_DEPRECATION_WARNING=1

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

