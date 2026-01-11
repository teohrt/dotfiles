#!/bin/bash

CONFIG_DIR="${HOME}/dotfiles/.shell_config"

# Detect OS
case "$(uname -s)" in
    Linux*)  OS="linux" ;;
    Darwin*) OS="mac" ;;
    *)       OS="unknown" ;;
esac

# Load agnostic configs, then OS-specific
for dir in "${CONFIG_DIR}/agnostic" "${CONFIG_DIR}/${OS}"; do
    [ -d "$dir" ] && for f in "$dir"/*; do
        [ -f "$f" ] && source "$f"
    done
done
