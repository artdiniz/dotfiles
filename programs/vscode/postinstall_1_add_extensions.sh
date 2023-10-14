_SCRIPT_PATH="$(_get_script_path)"

_extensions_file_path="$_SCRIPT_PATH/files/extensions.txt"

extensions="$(cat "$_extensions_file_path")"

_log echo
_log echo "Installing VSCode extensions"
_log echo
_log echo "$extensions"

if _log _confirm "Confirm?" "n"; then
    for extension in $extensions; do
        _DOTFILES_STRICT_MODE=0 code --install-extension "$extension"
    done
else
    echo "Skipped installing"
fi

