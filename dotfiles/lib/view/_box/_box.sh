. "$_DOTFILES_DIR"/dotfiles/lib/view/_box/_parse_border_description_syntax.sh
. "$_DOTFILES_DIR"/dotfiles/lib/view/_box/_repeat_string.sh
. "$_DOTFILES_DIR"/dotfiles/lib/view/_box/_clock_wise_set_values.sh

function _box {
    local _content="$1"
    local _border_descriptors="$2"
    local _padding_sizes="$3"

    local _top_box_string="–"
    local _right_box_string="|"
    local _bottom_box_string="–"
    local _left_box_string="|"

    _clock_wise_set_values "$_border_descriptors" _top_box_string _right_box_string _bottom_box_string _left_box_string

    local _padding_top_size=0
    local _padding_right_size=0
    local _padding_bottom_size=0
    local _padding_left_size=0

    _clock_wise_set_values "$_padding_sizes" _padding_top_size _padding_right_size _padding_bottom_size _padding_left_size

    function _render_box_line {
        local _text="$1"
        local _line_number="$2"
        
        local _current_left_box_char_position=$(( ($_line_number % ${#_left_box_string}) ))
        local _current_left_box_char="${_left_box_string:$_current_left_box_char_position:1}"

        local _current_right_box_char_position=$(( ($_line_number % ${#_right_box_string}) ))
        local _current_right_box_char="${_right_box_string:$_current_right_box_char_position:1}"

        local _padding_right="$(_repeat_string "$_padding_right_size")"
        local _padding_left="$(_repeat_string "$_padding_left_size")"

        printf "%b%b%b%b%b" "$_current_left_box_char" "$_padding_left" "$_text" "$_padding_right" "$_current_right_box_char"
    }

    # Get content dimensions
    local _content_colum_count=0
    local _content_lines_count=0
    while IFS= read -r _content_line; do
        local _current_line_column_count="${#_content_line}"
        [ $_content_colum_count -lt $_current_line_column_count ] && _content_colum_count="$_current_line_column_count";
        _content_lines_count=$(( _content_lines_count + 1 ))
    done <<<"$_content"

    local _box_content=""
    local _current_box_line_number=$_padding_top_size
    while IFS=  read -r _content_line; do
        local _current_line_column_count="${#_content_line}"

        local _padding_end_size=$(( _content_colum_count - _current_line_column_count ))
        local _padding_end="$(_repeat_string "$_padding_end_size")"

        _box_content+="$(_render_box_line "$_content_line$_padding_end" "$_current_box_line_number")\\n"
        _current_box_line_number=$(( _current_box_line_number + 1 ))
    done <<<"$_content"

    local _box_horizontal_borders_width=$(( _padding_left_size + _content_colum_count + _padding_right_size ))
    
    local _box_top_border_repeat_number=$(( ($_box_horizontal_borders_width / ${#_top_box_string}) + 1 ))
    local _box_top_border="$(_repeat_string "$_box_top_border_repeat_number" "$_top_box_string")"
    local _box_top_border=" ${_box_top_border:0:$_box_horizontal_borders_width}"

    local _box_bottom_border_repeat_number=$(( ($_box_horizontal_borders_width / ${#_bottom_box_string}) + 1 ))
    local _box_bottom_border="$(_repeat_string "$_box_bottom_border_repeat_number" "$_bottom_box_string")"
    local _box_bottom_border=" ${_box_bottom_border:0:$_box_horizontal_borders_width}"
    
    local _box_padding_top=""
    local _box_padding_bottom=""

    local _vertical_padding_filler="$(_repeat_string "$_content_colum_count")"
    local _vertical_padding_height=$(( $_padding_top_size + $_padding_bottom_size ))
    local i=0; while [ $i -lt "$_vertical_padding_height" ]; do
        if [ $i -lt $_padding_top_size ]; then
            _box_padding_top+="$(_render_box_line "$_vertical_padding_filler" "$i")\\n"
        else
            _box_padding_bottom+="$(_render_box_line "$_vertical_padding_filler" "$(( $_content_lines_count + $i ))")\\n"
        fi
        i=$(( i + 1 ))
    done

    printf "%b" "$_box_top_border \n"
    printf "%b" "$_box_padding_top"
    printf "%b" "$_box_content"
    printf "%b" "$_box_padding_bottom"
    printf "%b" "$_box_bottom_border \n"
}