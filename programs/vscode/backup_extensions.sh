_SCRIPT_PATH="$(_get_script_path)"
_extensions_file_path="$_SCRIPT_PATH/files/extensions.txt"

if which code >/dev/null; then
    _DOTFILES_STRICT_MODE=0 code --list-extensions | _create_and_write_file "$_extensions_file_path"
else
    _throw 1 "Install code cli"
fi

