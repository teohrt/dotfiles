# Login shell config - sources load_config.sh (guard prevents double-sourcing with .zshrc)
if [ -f "${HOME}/.config/my-shell/load_config.sh" ]; then
    . "${HOME}/.config/my-shell/load_config.sh"
else
    echo "Warning: load_config.sh not found" >&2
fi
