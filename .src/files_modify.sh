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


_files_modify_output="$(
	"$_program_path/files_modify.sh"
)"

_files_mod_json_handler="_json_utils"
_files_mod_yaml_handler="" #TODO
_files_mod_xml_handler="" #TODO

function _resolve_file_mod_path {
	_target_file_path_input="$1"
	_target_file_path_var_name="$2"
	_target_prop_path_var_name="$3"
	_target_file_extension_var_name="$4"

	_target_file_path_input_base="$(printf "$_target_file_path_input" | awk -F'.' '{print $1}')"
	_resolved_file_path="$_target_file_path_input_base"
	_resolved_prop_path=""

	while read -r _prop_path; do
		if [ ! -r "$_resolved_file_path" ] && [ -r "$_resolved_file_path${_resolved_prop_path:+.}$_resolved_prop_path" ]; then
			_resolved_file_path="$_resolved_file_path${_resolved_prop_path:+.}$_resolved_prop_path"
			_resolved_prop_path=""
		fi
		_resolved_prop_path="$_prop_path${_resolved_prop_path:+.}$_resolved_prop_path"
	done <<< "$(printf "$_target_file_path_input" | awk -F'.' '{for(i=NF;i>1;i--){print $i}}')"

	if [ -r "$_resolved_file_path${_resolved_prop_path:+.}$_resolved_prop_path" ]; then
		_resolved_file_path="$_resolved_file_path${_resolved_prop_path:+.}$_resolved_prop_path"
		_resolved_prop_path=""
	fi

	_resolved_file_path_base="$(printf "$_resolved_file_path" | awk -F'.' '{print $1}')"
	_resolved_file_path_extension="$(printf "$_resolved_file_path" | awk -F'.' '{print $NF}')"

	_resolved_prop_path_extension="$(printf "$_resolved_prop_path" | awk -F'.' '{print $NF}')"
	
	_resolved_file_extension=""
	if [ "$_resolved_file_path_base" != "$_resolved_file_path_extension" ]; then
		_resolved_file_extension="$_resolved_file_path_extension"
	elif [ ! -z "$_resolved_prop_path_extension" ]; then
		_resolved_file_extension="$_resolved_prop_path_extension"
		_resolved_prop_path="${_resolved_prop_path%%.$_resolved_prop_path_extension}"
	fi

	_create_string_var "$_target_file_path_var_name" < <(printf "$_resolved_file_path")
	_create_string_var "$_target_prop_path_var_name" < <(printf "$_resolved_prop_path")
	_create_string_var "$_target_file_extension_var_name" <  <(printf  "$_resolved_file_extension")
}

while read -r _files_modify_line; do
	_src_file_path="$_program_path/files/$(basename "$_files_modify_line")"

	if [ ! -r "$_src_file_path" ]; then
		printf "%s\n\n" "Source file not found. Can't get modifications from $(_style "$_src_file_path" $_underline)"
		continue
	fi

	_resolve_file_mod_path "$_files_modify_line" _target_file_path _target_prop_path _target_file_extension

	if [ ! -r "$_target_file_path" ]; then
		printf "%s\n\n" "Target file not found. Can't modify $(_style "$_target_file_path" $_underline)"
		continue
	fi

	_files_mod_handler_name="_files_mod_${_target_file_extension}_handler"
	if [ -z "${!_files_mod_handler_name:-}" ]; then
		printf "%s\n\n" "Not a supported file extension for modification: '$_target_file_extension'"
		continue
	fi
	
	_target_file_name="$(basename "$_target_file_path")"
	
	if [ -r "$_target_file_path" ] || [ -L "$_target_file_path" ]; then
		if _confirm "File $(_style "$_target_file_name" $_underline) already exists. Back it up and overwrite it?" "n"; then
			_backup_dir="$_program_path/backup"
			_backup_file_path="$_backup_dir/$_target_file_name"
			
			mkdir -p "$_backup_dir"
			cp "$_target_file_path" "$_backup_file_path"
		else
			printf "Aborting mod overwrite $(_style "$_target_file_path" $_underline)\n\n"
			continue
		fi
	fi

	_log printf "%s\n%s\n%s\n%s\n\n" \
		"Handler:      ${!_files_mod_handler_name}" \
		"Copying:      $(_parse_to_path_with_tilde "$_src_file_path")" \
		"Target file:  $(_parse_to_path_with_tilde "$_target_file_path")" \
		"Target prop:  $_target_prop_path" \

	if ${!_files_mod_handler_name} write "$(cat "$_target_file_path")" "$_target_prop_path" "$(cat "$_src_file_path")" > "$_target_file_path"; then
	    printf "Success modifying: $_target_file_name$(_style "@" "$_text_cyan" "$_bold")$_target_prop_path\n\n"
	else
	    cat "$_backup_file_path" > "$_target_file_path"
	    printf "Failed modifying: $_target_file_name$(_style "@" "$_text_cyan" "$_bold")$_target_prop_path\n\n"
	fi

done <<< "$_files_modify_output"

