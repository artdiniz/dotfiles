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
    local _box_strings="$2"
    local _padding_sizes="$3"

    local _top_box_string="–"
    local _right_box_string="|"
    local _bottom_box_string="–"
    local _left_box_string="|"

    _clock_wise_set_values "$_box_strings" _top_box_string _right_box_string _bottom_box_string _left_box_string

    local _padding_top_size=0
    local _padding_right_size=0
    local _padding_bottom_size=0
    local _padding_left_size=0

    _clock_wise_set_values "$_padding_sizes" _padding_top_size _padding_right_size _padding_bottom_size _padding_left_size

    function _apply_line_padding {
        local _text="$1"
        local _padding_right="$(_repeat_string "$_padding_right_size")"
        local _padding_left="$(_repeat_string "$_padding_left_size")"

        printf "%b%b%b%b%b" "$_left_box_string" "$_padding_left" "$_text" "$_padding_right" "$_right_box_string"
    }

    local _colum_count=0
    while IFS=  read -r _content_line; do
        ((_colum_count<${#_content_line})) && { _colum_count="${#_content_line}"; }
    done <<<"$_content"

    local _box_content=""
    while IFS=  read -r _content_line; do
        local _current_line_count="${#_content_line}"

        local _padding_end_size=$((_colum_count - _current_line_count))
        local _padding_end="$(_repeat_string "$_padding_end_size")"

        _box_content+="$(_apply_line_padding "$_content_line$_padding_end")\\n"
    done <<<"$_content"

    local _box_horizontal_borders_size=$((_colum_count + _padding_right_size + _padding_left_size))

    local _box_top_border=""
    local i=0; while [ $i -lt ${#_top_box_string} ]; do
        _box_top_border+="$(_repeat_string "${#_left_box_string}" " ")$(_repeat_string "$_box_horizontal_borders_size" "${_top_box_string:$i:1}")"

        i=$(( i + 1 ))
        [ $i -lt ${#_top_box_string} ] && _box_top_border+="\n"
    done

    local _box_bottom_border=""
    local i=0; while [ $i -lt ${#_bottom_box_string} ]; do
        _box_bottom_border+="$(_repeat_string "${#_left_box_string}" " ")$(_repeat_string "$_box_horizontal_borders_size" "${_bottom_box_string:$i:1}")"

        i=$(( i + 1 ))
        [ $i -lt ${#_bottom_box_string} ] && _box_bottom_border+="\n"
    done
    
    local _box_padding_line="$(_apply_line_padding "$(_repeat_string "$_colum_count")")\\\n"
    local _box_padding_top="$(_repeat_string "$_padding_top_size" "$_box_padding_line")"
    local _box_padding_bottom="$(_repeat_string "$_padding_bottom_size" "$_box_padding_line")"
    

    printf "$_box_top_border \n"
    printf "$_box_padding_top"
    printf "$_box_content"
    printf "$_box_padding_bottom"
    printf "$_box_bottom_border \n"
}