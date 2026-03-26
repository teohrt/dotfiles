#!/bin/bash

# ~/.bashrc template
# This file sources your OS-specific dotfiles configuration

# Source the load_config script from dotfiles
if [ -f "${HOME}/load_config.sh" ]; then
    source "${HOME}/load_config.sh"
else
    echo "Warning: load_config.sh not found at ${HOME}/load_config.sh" >&2
fi
