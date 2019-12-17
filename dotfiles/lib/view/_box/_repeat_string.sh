function _repeat_string {
    local _repeat_size="$1"
    local _string_repeat="$(printf '%s' "$2")"

    [ -z "$_string_repeat" ] && local _string_repeat=' ';
    
    local _string_length="${#_string_repeat}"

    local  _number_of_backslashes="$(awk -F'\' '{print NF-1}'<<<"$_string_repeat")"
    local _number_of_non_backslashes=$(( $_string_length - $_number_of_backslashes ))

    _string="$(sed 's/\\/\\\\/g' <<< "$_string_repeat")"
    
    _repeat_size="$(( $_repeat_size * ( $_number_of_backslashes + 1 ) ))"
    
    # if [ $_number_of_backslashes -gt 0 ]; then
    #     # _string_length="$(printf "%s" "$_string_repeat" | wc -m | xargs)"
    # fi
  
    local _repeat
    if [ $_string_length -gt 1 ]; then
        _repeat=$(( ($_repeat_size / $_string_length) + 1 ))
        printf "%s" "$_repeat_size $_number_of_backslashes"
    else
        _repeat="$_repeat_size"
        printf "%s" "$_repeat_size $_number_of_backslashes"
    fi

    local _result_with_tail=""
    local i=0; while [ $i -lt $_repeat ]; do
        _result_with_tail+="$_string_repeat"
        i=$(( $i + 1 ))
    done

    # printf "%s" "$_repeat_size $_repeat $_number_of_backslashes $_result_with_tail"


    # if [ $_number_of_backslashes -gt 0 ]; then
    #     printf "%s" "$_repeat_size $_repeat $_number_of_backslashes [$_result_with_tail]"

    #     _repeat_size="$(( $_repeat_size * $_number_of_backslashes * 2 ))"

    #     # printf "$_repeat_size $_number_of_backslashes"
    # fi

    local _result="${_result_with_tail:0:$_repeat_size}"

    printf "%s" "$_result"
}