# Interactive shell config - sources load_config.sh

if [ -f "${HOME}/load_config.sh" ]; then
    source "${HOME}/load_config.sh"
else
    echo "Warning: load_config.sh not found" >&2
fi
