function _create_string_var {
	local _var_name
	_var_name="$1"

	IFS='' read -rd '' "$_var_name" || [ $? -eq 1 ] && :
}
