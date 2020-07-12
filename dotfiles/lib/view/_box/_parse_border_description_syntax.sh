function _parse_border_description_syntax {
	local _raw_border="$1"
	local _border_var_name="$2"
	local _border_length_var_name="$3"

	local _parsed_borders _qt_borders

	local _special_chars_by_alias
	_create_string_var _special_chars_by_alias <<-SPECIAL_CHARS_BY_ALIAS
		s 
		t	
	SPECIAL_CHARS_BY_ALIAS

	while IFS= read -r _special_char_and_alias; do
		local _alias="${_special_char_and_alias:0:1}"
		local _char="${_special_char_and_alias:1:2}"

		# echo "alias: '$_alias' || char '$_char'"
		# _create_string_var _raw_border < <(printf %s "$_raw_border" | sed -e "s/\\\\$_alias/$_char/")
		_create_string_var _raw_border < <(printf %s "${_raw_border/\\$_alias/$_char}")
	done <<<"$(printf '%s' "$_special_chars_by_alias")"


	# if _raw_border is a number (-eq only works for integers)
	local first_border_char="${_raw_border:0:1}"
	local second_border_char="${_raw_border:1:1}"
	local last_border_char="${_raw_border:$(( ${#_raw_border} - 1 )):1}"

	if [ "$first_border_char" -eq "$first_border_char" ] 2> /dev/null && [ "$second_border_char" = "(" ] && [ "$last_border_char" = ")" ] ; then
		_qt_borders=$first_border_char
		local _borders_description=${_raw_border:1}	
		
		local _qt_parsed_borders=0

		local _STATE_UNKNOWN=0
		local _STATE_NOT_READING=1
		local _STATE_START_READING=2
		local _STATE_READING=3
		local _STATE_READING_ESCAPE_NEXT=4
		local _STATE_END_READING=5

		function _set_state {
			local _char="$1"
			local _state_var_name="$2"
			local _previous_state=${!_state_var_name}

			local _state
			# echo "#char => $_char"
			function _result {
				local _new_state=$1
				# echo "# => $_state_var_name = $_new_state"
				_create_string_var "$_state_var_name" < <(printf '%s' "$_new_state")
			}

			if [ $_previous_state -eq $_STATE_NOT_READING ] || [ $_previous_state -eq $_STATE_END_READING ]; then
				if [ "$_char" = "(" ]; then
					_result $_STATE_START_READING
					return
				fi
			fi

			if [ $_previous_state -eq $_STATE_READING_ESCAPE_NEXT ]; then
				_result $_STATE_READING
				return
			fi

			if [ $_previous_state -eq $_STATE_START_READING ] || [ $_previous_state -eq $_STATE_READING ]; then
				if [ "$_char" = ")" ]; then
					_result $_STATE_END_READING
					return
				elif [ "$_char" = '\' ]; then
					_result $_STATE_READING_ESCAPE_NEXT
					return
				else
					_result $_STATE_READING
					return
				fi
				
			fi

			_result $_STATE_UNKNOWN
		}

		local _current_border=""
		local _state_reading_border=$_STATE_NOT_READING
		while [ $_qt_parsed_borders -lt $_qt_borders ] && read -n1 -r _borders_description_char; do
			_set_state "$_borders_description_char" _state_reading_border

			if [ $_state_reading_border -eq $_STATE_READING ]; then
				if [ "$_borders_description_char" = '\' ]; then
					_current_border+='\\'
				else
					_current_border+="$_borders_description_char"
				fi
			fi

			if [ $_state_reading_border -eq $_STATE_START_READING ]; then
				_current_border=''
			fi

			if [ $_state_reading_border -eq $_STATE_END_READING ]; then
				_parsed_borders+=$_current_border\\n
				_qt_parsed_borders=$(( $_qt_parsed_borders + 1))
				_current_border=''
			fi

		done <<< "$_borders_description"
	else
		_qt_borders=1
		_parsed_borders="$_raw_border"
	fi

	_create_string_var "$_border_var_name" < <(printf '%s' "$_parsed_borders")
	if [ ! -z "$_border_length_var_name" ]; then
		_create_string_var "$_border_length_var_name" < <(printf '%s' "$_qt_borders")
	fi
}
