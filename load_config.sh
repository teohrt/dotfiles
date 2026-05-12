#!/bin/sh

# Prevent double-sourcing (macOS opens login shells, running both .zprofile and .zshrc)
[ -n "$_SHELL_CONFIG_LOADED" ] && return
_SHELL_CONFIG_LOADED=1

# Works in both bash and zsh
if [ -n "$ZSH_VERSION" ]; then
    CONFIG_DIR="$(dirname "$(realpath "${(%):-%x}")")/.shell_config"
else
    CONFIG_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")/.shell_config"
fi

# Source Nix profile if present (must happen early so Nix-installed tools are on PATH)
if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
elif [ -e "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]; then
    . "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
fi

# Detect OS
case "$(uname -s)" in
    Linux*)  OS="linux" ;;
    Darwin*) OS="mac" ;;
    *)       OS="unknown" ;;
esac

# Load OS-specific then agnostic configs
for dir in "${CONFIG_DIR}/${OS}" "${CONFIG_DIR}/agnostic"; do
    [ -d "$dir" ] && for f in "$dir"/*; do
        [ -f "$f" ] && source "$f"
    done
done

# Zsh completions setup
if [ -n "$ZSH_VERSION" ]; then
    autoload -Uz compinit && compinit
    zstyle ':completion:*' menu select
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # case-insensitive
fi
