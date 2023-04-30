function _select {
	local _select_prompt="$1"
	local _options="$2"
	local _selected_options="${3:-}"
	local _selection=""
	local _stop=1
	
	_log echo "==== "
	_log echo "$_select_prompt"
	local _rendered_line_count=$(( 1 + $(_count_render_lines "$_select_prompt") ))

	if [ ! -z "$_selected_options" ]; then
		_log echo "==== Selected"
		IFS=$'\n' _log printf '   - %b\n' $_selected_options
		_log echo "===="
		_rendered_line_count=$(( $_rendered_line_count + $(_count_render_lines "$_selected_options") + 2 ))
	else
		_log echo "==== "
		_rendered_line_count=$(( $_rendered_line_count + 1 ))
	fi

	_not_selected_options="$(
		comm -23 /dev/fd/3 /dev/fd/4 3<<-FILE1 4<<-FILE2
			$(
				sort <<-SORT
					$_options
				SORT
			)
		FILE1
			$(
				sort <<-SORT
					$_selected_options
				SORT
			)
		FILE2
	)"

	select _script_name in $_not_selected_options "CONTINUE"; do
		if [ "$_script_name" = "CONTINUE" ]; then
			_stop=0
		fi
		_selection="$_script_name"
		break
	done

	_rendered_line_count=$(( $_rendered_line_count + $(_count_render_lines "$_not_selected_options") + 2 ))
	_log _clear_n_lines_above $(( _rendered_line_count ))

	if [ $_stop -eq 0 ]; then
		printf '%b' "$_selected_options"
		return 0
	fi

	if [ ! -z "$_selection" ]; then
		_selected_options="$_selected_options$_selection"$'\n'
	fi

	_select "$_select_prompt" "$_options" "$_selected_options"
}
