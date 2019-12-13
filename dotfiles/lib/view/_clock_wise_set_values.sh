function _clock_wise_set_values {
    local _param_values="$1"

    local _top_value_var_name="$2"
    local _right_value_var_name="$3"
    local _bottom_value_var_name="$4"
    local _left_value_var_name="$5"

    local _top_value _right_value _bottom_value _left_value

    IFS=' ' read -ra _values_array<<<"$_param_values"

    if [ ! -z "${_values_array[0]}" ]; then
        if [ -z "${_values_array[1]}" ]; then
            _value="${_values_array[0]}"
            _top_value="$_value"
            _right_value="$_value"
            _bottom_value="$_value"
            _left_value="$_value"
        elif [ -z "${_values_array[2]}" ]; then
            _vertical_value="${_values_array[0]}"
            _horizontal_value="${_values_array[1]}"

            _top_value="$_vertical_value"
            _right_value="$_horizontal_value"
            _bottom_value="$_vertical_value"
            _left_value="$_horizontal_value"
        elif [ -z "${_values_array[3]}" ]; then
            _top_value="${_values_array[0]}"
            _horizontal_value="${_values_array[1]}"
            _bottom_value="${_values_array[2]}"
            
            _right_value="$_horizontal_value"
            _left_value="$_horizontal_value"
        else
            _top_value="${_values_array[0]}"
            _right_value="${_values_array[1]}"
            _bottom_value="${_values_array[2]}"
            _left_value="${_values_array[3]}"
        fi

        read -r "$_top_value_var_name" <<< "$_top_value"
        read -r "$_right_value_var_name" <<< "$_right_value"
        read -r "$_bottom_value_var_name" <<< "$_bottom_value"
        read -r "$_left_value_var_name" <<< "$_left_value"
    fi
}
