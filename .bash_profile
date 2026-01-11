# Standard profile
# ----------------
 
# M1 Mac Brew pathing
eval "$(/opt/homebrew/bin/brew shellenv)"

# M1 Mac docker
DOCKER_DEFAULT_PLATFORM="linux/amd64"

# With Mac's default interactive shell now zsh, we'll want to silence the obnoxious message
export BASH_SILENCE_DEPRECATION_WARNING=1