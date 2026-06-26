source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh

# M1 Mac Brew pathing
eval "$(/opt/homebrew/bin/brew shellenv)"

# M1 Mac docker
export DOCKER_DEFAULT_PLATFORM="linux/amd64"

alias ip="ipconfig getifaddr en0"
alias mac="networksetup -getmacaddress en0"

wifipwd () { # Retrieve wifi password - fuzzy match SSIDs if none is provided
    local network
    network=$1
    if [ "$network" = "" ] ; then
      network=$(networksetup -listpreferredwirelessnetworks en0 | awk '{$1=$1};1' | fzf)
    fi
    if [ "$network" != "" ] ; then # network could still be empty if fzf was exited
      echo "Network: $network"
      security find-generic-password -ga "$network" | grep "password:"
    fi
}
