function _repeat_string {
    local _repeat_size="$1"
    local _string_repeat="$2"

    [ -z "$_string_repeat" ] && local _string_repeat=' ';
    
    local _string_length="${#_string_repeat}"
  
    local _repeat
    if [ $_string_length -gt 1 ]; then
        _repeat=$(( ($_repeat_size / $_string_length) + 1 ))
    else
        _repeat="$_repeat_size"
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

    local  _number_of_backslashes="$(awk -F'\' '{print NF-1}'<<<"$_string_repeat")"

    if [ $_number_of_backslashes -gt 0 ]; then
        sed 's/\\/\\\\/g' <<< "$_result"
    else
        printf %s "$_result"
    fi
}