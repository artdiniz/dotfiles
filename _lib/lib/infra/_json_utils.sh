function _json_utils {
    local _SCRIPT_PATH="$(dirname "$BASH_SOURCE")"
    if "$_SCRIPT_PATH/_json_utils.js.sh" "$@"; then
        return 0
    else
        return $?
    fi
}
