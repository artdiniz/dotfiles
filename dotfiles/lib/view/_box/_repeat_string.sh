function _repeat_string {
    local _size="$1"
    local _char="$2"
    
    local _printf_repeat=%"$_size"s

    test -z "$_char" \
        && printf "$_printf_repeat" \
        || printf "$_printf_repeat" | sed "s/ /$_char/g"
}