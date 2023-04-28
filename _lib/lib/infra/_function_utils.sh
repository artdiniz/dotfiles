function _function_exists {
    command -V "$1" 2>/dev/null | grep -qiE '\bfunction\b'
    return $?
}
