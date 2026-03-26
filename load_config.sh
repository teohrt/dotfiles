#!/bin/bash

CONFIG_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")/.shell_config"

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
