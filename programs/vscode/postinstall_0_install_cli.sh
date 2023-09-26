if which code; then
    exit
fi

_vscode_binary_path=""

if [ _is_macos ]; then
    _vscode_binary_path="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
fi

if [ ! -z "$_vscode_binary_path" ]; then
    mkdir -p /usr/local/bin
    ln -s "$_vscode_binary_path" /usr/local/bin/code
fi