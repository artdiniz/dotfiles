#!/usr/bin/env bash
_dotfiles_src_dir="$(cd "$(dirname "$BASH_SOURCE")"; pwd)"
. "$_dotfiles_src_dir/.dotfiles_env_source.sh"

_program_path="$1"

if [ -d "$_program_path" ]; then
	_program_path="$(cd "$_program_path"; pwd)"
elif [ -d "$_DOTFILES_DIR/programs/$_program_path" ]; then
	_program_path="$_DOTFILES_DIR/programs/$_program_path"
elif [ -d "$_DOTFILES_DIR/shell/$_program_path" ]; then
	_program_path="$_DOTFILES_DIR/shell/$_program_path"
else
	printf "Unknown program $_program_path\n\n"
	exit 1
fi


_files_copy_output="$(
	"$_program_path/files_copy.sh"
)"

_files_copy_json_handler="_json_utils"
_files_copy_yaml_handler="" #TODO
_files_copy_xml_handler="" #TODO


function _resolve_file_copy_path {
	_target_file_path_input="$1"
	_target_path_var="$2"
	_target_nested_prop_path_var="$3"
	_target_file_nested_prop_format_var="$4"

	_target_file_path_input_base="$(printf "$_target_file_path_input" | awk -F'.' '{print $1}')"
	_resolved_file_path="$_target_file_path_input_base"
	_resolved_prop_path=""

	while read -r _prop_path; do
		if [ -r "$_resolved_file_path.$_resolved_prop_path" ]; then
			_resolved_file_path="$_file_path.$_resolved_prop_path"
		else
			_resolved_prop_path="$_prop_path${_resolved_prop_path:+.}$_resolved_prop_path"
		fi
	done <<< "$(printf "$_target_file_path_input" | awk -F'.' '{for(i=NF;i>1;i--){print $i}}')"

	_resolved_file_path_base="$(printf "$_resolved_file_path" | awk -F'.' '{print $1}')"
	_resolved_file_path_extension="$(printf "$_resolved_file_path" | awk -F'.' '{print $NF}')"

	_resolved_nested_prop_path_extension="$(printf "$_resolved_prop_path" | awk -F'.' '{print $NF}')"

	_resolved_file_extension=""
	if [ -z "$_resolved_prop_path" ]; then
		:
	elif [ "$_resolved_file_path_base" != "$_resolved_file_path_extension" ]; then
		_files_copy_ext_handler_name="_files_copy_${_resolved_file_path_extension}_handler"
		if [ ! -z "${!_files_copy_ext_handler_name:-}" ]; then
			_resolved_file_extension="$_resolved_file_path_extension"
		fi
	elif [ ! -z "$_resolved_nested_prop_path_extension"  ]; then
		_files_copy_ext_handler_name="_files_copy_${_resolved_nested_prop_path_extension}_handler"
		if [ ! -z "${!_files_copy_ext_handler_name:-}" ]; then
			_resolved_file_extension="$_resolved_nested_prop_path_extension"
			_resolved_prop_path="${_resolved_prop_path%%.$_resolved_nested_prop_path_extension}"
		else
			_resolved_file_path="$_target_file_path_input"
			_resolved_file_extension=""
			_resolved_prop_path=""
		fi
	fi

	_create_string_var "$_target_path_var" < <(printf "$_resolved_file_path")
	_create_string_var "$_target_nested_prop_path_var" < <(printf "$_resolved_prop_path")
	_create_string_var "$_target_file_nested_prop_format_var" <  <(printf  "$_resolved_file_extension")
}

while read -r _files_copy_line; do
	_src_file_path="$_program_path/files/$(basename "$_files_copy_line")"

	if [ ! -r "$_src_file_path" ]; then
		printf "%s\n\n" "File not found. Can't create copy of $(_style "$_src_file_path" $_underline)."
		continue
	fi

	_resolve_file_copy_path "$_files_copy_line" _target_file_path _target_file_nested_prop_path _target_file_nested_prop_format
	
	_target_file_name="$(basename "$_target_file_path")"
	
	if [ -r "$_target_file_path" ] || [ -L "$_target_file_path" ]; then
		if _confirm "File $(_style "$_target_file_name" $_underline) already exists. Back it up and overwrite it?" "n"; then
			_backup_dir="$_program_path/backup"
			_backup_file_path="$_backup_dir/$_target_file_name"
			
			mkdir -p "$_backup_dir"
			cp "$_target_file_path" "$_backup_file_path"
		else
			printf "Aborting copy overwrite $(_style "$_target_file_path" $_underline)\n\n"
			continue
		fi
	fi

	if [ "$_target_file_nested_prop_format" == 'json' ]; then
		_log printf "%s\n%s\n%s\n\n" \
			"Copying JSON:  $_src_file_path" \
			"To JSON prop:  $_target_file_nested_prop_path" \
			"To file:       $_target_file_path"

		if _json_utils write "$(cat "$_target_file_path")" "$_target_file_nested_prop_path" "$(cat "$_src_file_path")" > "$_target_file_path"; then
		    printf "Success copying: $(_style "$_target_file_name" $_underline)\n\n"
		else
		    cat "$_backup_file_path" > "$_target_file_path"
		    printf "Failed copying: $(_style "$_target_file_name" $_underline)\n\n"
		fi
	else
		# _target_file_path="$_target_file_path${_target_file_nested_prop_path:+.}$_target_file_nested_prop_path${_target_file_nested_prop_format:+.}$_target_file_nested_prop_format"
		# _target_file_name="$(basename "$_target_file_path")"

		printf "%s\n%s\n\n" \
		"Copying: $_src_file_path" \
		"To:      $_target_file_path"
	
		if cat "$_src_file_path" > "$_target_file_path"; then
		    printf "Success copying: $(_style "$_target_file_name" $_underline)\n\n"
		else
		    cat "$_backup_file_path" > "$_target_file_path"
		    printf "Failed copying: $(_style "$_target_file_name" $_underline)\n\n"
		fi
	fi

done <<< "$_files_copy_output"

