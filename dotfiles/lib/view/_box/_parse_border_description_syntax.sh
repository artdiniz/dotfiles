function _parse_border_description_syntax {
	local _raw_border="$1"
	local _border_var_name="$2"
	local _border_length_var_name="$3"

	local _parsed_borders _qt_borders

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


		local _previous_state=$_STATE_NOT_READING
		function _set_state {
			local _char="$1"
			local _state_var_name="$2"

			local _state

			function _result {
				_previous_state="$1"
				read -d '' -r $_state_var_name <<<"$1"
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
		while [ $_qt_parsed_borders -lt $_qt_borders ] && read -n1 -r _borders_description_char; do

			local _state_reading_border

			_set_state "$_borders_description_char" _state_reading_border

			if [ $_state_reading_border -eq $_STATE_READING ]; then
				if [ "$_borders_description_char" = '\' ]; then
					_current_border+="\\\\"
				else
					_current_border+="$_borders_description_char"
				fi
			fi

			if [ $_state_reading_border -eq $_STATE_START_READING ]; then
				_current_border=""
			fi

			if [ $_state_reading_border -eq $_STATE_END_READING ]; then
				_parsed_borders+="$_current_border\\\n"
				_qt_parsed_borders=$(( $_qt_parsed_borders + 1))
				_current_border=""
			fi

		done <<< "$_borders_description"
	else
		_qt_borders=1
		_parsed_borders="$_raw_border"
	fi

	read -d '' -r $_border_var_name <<<"$_parsed_borders"
	if [ ! -z "$_border_length_var_name" ]; then
		read -d '' -r $_border_length_var_name <<<"$_qt_borders"

	fi
}
