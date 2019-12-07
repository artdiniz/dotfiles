if _is_osx; then
    echo "$HOME/Library/Application Support/Code/User/settings.json"
    echo "$HOME/Library/Application Support/Code/User/keybindings.json"
else
    echo "$HOME/.config/Code/User/settings.json"
    echo "$HOME/.config/Code/User/keybindings.json"
fi
