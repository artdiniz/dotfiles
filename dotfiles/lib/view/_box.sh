function _repeat_string {
    local _size="$1"
    local _char="$2"
    
    local _printf_repeat=%"$_size"s

    test -z "$_char" \
        && printf "$_printf_repeat" \
        || printf "$_printf_repeat" | sed "s/ /$_char/g"
}

function _box {
    local _content="$1"
    local _box_chars="$2"

    local _horizontal_box_chars="${_box_chars:0:1}"
    local _vertical_box_chars
    test -z "${_box_chars:1:1}" \
        && _vertical_box_chars="$_horizontal_box_chars" \
        || _vertical_box_chars="${_box_chars:1:1}"
    
    local _padding_top_size _padding_right_size _padding_bottom_size _padding_left_size
    _padding_top_size=0
    _padding_right_size=0
    _padding_bottom_size=0
    _padding_left_size=0

    if [ ! -z "$(echo "${@:3}")" ]; then
        if [ -z "$(echo "${@:4}")" ]; then
            _padding_size="$3"
            _padding_top_size="$_padding_size"
            _padding_right_size="$_padding_size"
            _padding_bottom_size="$_padding_size"
            _padding_left_size="$_padding_size"
        elif [ -z "$(echo "${@:5}")" ]; then
            _padding_vertical_size="$3"
            _padding_horizontal_size="$4"
            _padding_top_size="$_padding_vertical_size"
            _padding_right_size="$_padding_horizontal_size"
            _padding_bottom_size="$_padding_vertical_size"
            _padding_left_size="$_padding_horizontal_size"
        elif [ -z "$(echo "${@:6}")" ]; then
            _padding_top_size="$3"
            _padding_bottom_size="$5"
            _padding_horizontal_size="$4"
            _padding_right_size="$_padding_horizontal_size"
            _padding_left_size="$_padding_horizontal_size"
        else
            _padding_top_size="$3"
            _padding_right_size="$4"
            _padding_bottom_size="$5"
            _padding_left_size="$6"
        fi
    fi

    function _apply_line_padding {
        local _text="$1"
        local _padding_right="$(_repeat_string "$_padding_right_size")"
        local _padding_left="$(_repeat_string "$_padding_left_size")"

        printf "$_vertical_box_chars$_padding_left$_text$_padding_right$_vertical_box_chars"
    }

    local _colum_count=0

    while IFS= read -r _content_line; do
        ((_colum_count<${#_content_line})) && { _colum_count="${#_content_line}"; }
    done <<<"$_content"

    local _parsed_content=""
    while IFS= read -r _content_line; do
        local _current_line_count="${#_content_line}"

        local _padding_end_size=$((_colum_count - _current_line_count))
        local _padding_end="$(_repeat_string "$_padding_end_size")"

        _parsed_content+="$(_apply_line_padding "$_content_line$_padding_end")\n"
    done <<<"$_content"
 
    local _box_hr=" $(_repeat_string "$((_colum_count + _padding_right_size + _padding_left_size))" "$_horizontal_box_chars") \n"
    
    local _box_wr="$(_apply_line_padding "$(_repeat_string "$_colum_count")") \\\n"
    local _box_padding_top="$(_repeat_string "$_padding_top_size" "$_box_wr")"
    local _box_padding_bottom="$(_repeat_string "$_padding_bottom_size" "$_box_wr")"

    printf "$_box_hr"
    printf "$_box_padding_top"
    printf "$_parsed_content"
    printf "$_box_padding_bottom"
    printf "$_box_hr"
}