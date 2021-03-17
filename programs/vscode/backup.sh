_extensions_file_path="$_SCRIPT_DIR/files/extensions.txt"

if which code; then
    code --list-extensions > files
else
    echo "Install code cli (postinstall-0-install_code_cli)" >&2
    exit 1
fi

code --list-extensions | _create_and_write_file "$_extensions_file_path"
