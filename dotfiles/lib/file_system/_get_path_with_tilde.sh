function _get_path_with_tilde {
    local _path="$1"
    local _path_dirname="$(dirname "$_path")"
    local _path_filename="$(basename "$_path")"

    local _pretty_path_dirname="$(cd "$_path_dirname"; _pwd="$(pwd)"; printf "${_pwd/#$HOME/~}")"

    printf "$_pretty_path_dirname/$_path_filename"
}
