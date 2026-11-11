# Source git-prompt.sh for __git_ps1 used in PS1
# Paths: Arch (/usr/share/git), NixOS (/run/current-system/sw/share/bash-completion)
_git_prompt_found=0
for _git_prompt in \
    /usr/share/git/completion/git-prompt.sh \
    /run/current-system/sw/share/bash-completion/completions/git-prompt.sh; do
    if [ -f "$_git_prompt" ]; then
        source "$_git_prompt"
        _git_prompt_found=1
        break
    fi
done
[ "$_git_prompt_found" -eq 0 ] && echo "Warning: git-prompt.sh not found, __git_ps1 unavailable" >&2
unset _git_prompt _git_prompt_found

alias open="xdg-open"

alias showip="ip route get 1.1.1.1 2>/dev/null | grep -oP 'src \K\S+'"
showmac() { ip link show "$(ip route | grep default | awk '{print $5}' | head -1)" 2>/dev/null | grep -oP '(?<=link/ether\s)\S+'; }

wifipwd () {
    local network
    network=$1
    if [ "$network" = "" ] ; then
      network=$(nmcli -t -f NAME,TYPE connection show | awk -F: '$2 == "802-11-wireless" {print $1}' | fzf)
    fi
    if [ "$network" != "" ] ; then
      echo "Network: $network"
      nmcli -s -g 802-11-wireless-security.psk connection show "$network"
    fi
}

# alias nrs="cd /home/trace/Dev/other/nixos/ && git pull && sudo nixos-rebuild switch --flake /home/trace/Dev/other/nixos#framework-16"
# alias nrb="cd /home/trace/Dev/other/nixos/ && git pull && sudo nixos-rebuild boot --flake /home/trace/Dev/other/nixos#framework-16"
# alias ncg="sudo nix-collect-garbage"
alias nrs="nh os switch"
alias nrb="nh os boot"
alias ncg="nh clean all"
