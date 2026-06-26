# Login shell config - sources load_config.sh (guard prevents double-sourcing with .zshrc)
if [ -f "${HOME}/load_config.sh" ]; then
    . "${HOME}/load_config.sh"
else
    echo "Warning: load_config.sh not found" >&2
fi
