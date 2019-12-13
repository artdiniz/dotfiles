function _clock_wise_set_values {
    local _param_values="$1"

    local _top_value _right_value _bottom_value _left_value

    if [ ! -z "$(echo "${_param_values:0}")" ]; then
        if [ -z "$(echo "${_param_values:1}")" ]; then
            _value="${_param_values:0:1}"
            _top_value="$_value"
            _right_value="$_value"
            _bottom_value="$_value"
            _left_value="$_value"
        elif [ -z "$(echo "${_param_values:2}")" ]; then
            _vertical_value="${_param_values:0:1}"
            _horizontal_value="${_param_values:1:1}"
            
            _top_value="$_vertical_value"
            _right_value="$_horizontal_value"
            _bottom_value="$_vertical_value"
            _left_value="$_horizontal_value"
        elif [ -z "$(echo "${_param_values:3}")" ]; then
            _top_value="${_param_values:0:1}"
            _bottom_value="${_param_values:2:2}"
            
            _horizontal_value="${_param_values:1:1}"
            _right_value="$_horizontal_value"
            _left_value="$_horizontal_value"
        else
            _top_value="${_param_values:0:1}"
            _right_value="${_param_values:1:1}"
            _bottom_value="${_param_values:2:2}"
            _left_value="${_param_values:3:3}"
        fi
    fi

}