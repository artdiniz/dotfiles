function _confirm {
    local _prompt_string="$1"
    local _default_value="$2"
    local _prompt_string_with_default_value

    case "$_default_value" in 
        y|Y)
            _prompt_string_with_default_value="$_prompt_string [Y/n]"
        ;;
        n|N)
            _prompt_string_with_default_value="$_prompt_string [y/N]"
        ;;
        *)
            _prompt_string_with_default_value="$_prompt_string [y/n]"
        ;;
    esac

    read -p "$_prompt_string_with_default_value " -er _answer

    [ ${#_answer} -eq 0 ] && _answer="$_default_value"

    _clear_n_lines_above 0

    case "$_answer" in 
        y|Y)
            printf "\n"
            return 0
        ;;
        n|N)
            printf "\n"
            return 1
        ;;
        *)
            _confirm "$_prompt_string" "$_default_value"
        ;;
    esac
}
