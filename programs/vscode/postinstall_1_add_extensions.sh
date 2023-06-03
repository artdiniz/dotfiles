_SCRIPT_PATH="$(_get_script_path)"

_extensions_file_path="$_SCRIPT_PATH/files/extensions.txt"

extensions="$(cat "$_extensions_file_path")"

echo
echo "Installing VSCode extensions"
echo
echo "$extensions"

_confirm "Confirm?" "n"

for extension in $extensions; do
    echo "code --install-extension '$extension'"
done
