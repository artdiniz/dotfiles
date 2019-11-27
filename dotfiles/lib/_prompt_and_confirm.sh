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

    printf '\e[1A\e[0K%s \e[4m%s\e[0m \n\n\e[36m%s\e[0m\n' \
        "$_prompt_string" \
        "$_answer" \
        "Confirm [y/N] and press Enter"

    read -p "" -er _has_confirmed

    printf '\e[0A\e[0K'
    printf '\e[1A\e[0K'
    printf '\e[1A\e[0K'
    printf '\e[1A\e[0K'

    if [ "$_has_confirmed" = 'y' ]; then
        # May be more portable like this: `eval $_result_var_name=\$_answer`, but `eval` scares me.
        read -r $_result_var_name <<< "$_answer"
    else
        _prompt_and_confirm "$_prompt_string" $_result_var_name
    fi
}