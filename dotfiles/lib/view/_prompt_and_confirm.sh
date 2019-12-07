function _prompt_and_confirm {
    local _prompt_string="$1"
    local _result_var_name="$2"
    local _default_value="${!_result_var_name}"
    local _prompt_string_with_default_value
    
    [ ${#_default_value} -gt 0 ] \
        && _prompt_string_with_default_value="$_prompt_string ("$_default_value")" \
        || _prompt_string_with_default_value="$_prompt_string"

    read -p "$_prompt_string_with_default_value " -er _answer

    [ ${#_answer} -eq 0 ] && _answer="$_default_value"

    _clear_n_lines_above 0

    printf '%s %s \n\n%s\n' \
        "$_prompt_string" \
        "$(test ! -z "$_answer" \
            && _style "$_answer" $_underline \
            ||  _style ' will be empty ' $_bg_black $_text_white $_bold \
        )" \
        "$(
            _style "Confirm [y/N] and press Enter" $_text_cyan
        )"

    read -p "" -er _has_confirmed

    if [ "$_has_confirmed" = 'y' ]; then
        _clear_n_lines_above 2
        printf "\n"

        # May be more portable like this: `eval $_result_var_name=\$_answer`, but `eval` scares me.
        read -r $_result_var_name <<< "$_answer"
    else
        _clear_n_lines_above 3
        _prompt_and_confirm "$_prompt_string" $_result_var_name
    fi
}
