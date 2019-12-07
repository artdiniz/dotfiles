_last_render=""

function _clear_n_lines_above {
    local _n_lines="$1"

    printf '\e[0A\e[0K'
    i=0; while [ $i -lt $_n_lines ]; do
        printf '\e[1A\e[0K'
        i=$(( i + 1 ))
    done
}

function _count_render_lines {
    local _render_string="$1"
    read -r _count <<< "$(printf "${_render_string#\\n}\n" | wc -l)"
    echo $_count
}


function _render {
    local _raw_render_string=""

    while read -r _stdin; do
        _raw_render_string+="$_stdin\\n"
    done

    function _render_function {
        local _render_string="$1"
        
        # _clear_n_lines $(_count_render_lines "$_last_render")
        # _last_render=_render_string

        printf "$_render_string"
    }

    printf "$(_render_function "$_raw_render_string")\\n"
}
