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
	_throw 1 "Unknown program $_program_path"
fi

_files_copy_output="$(
	"$_program_path/files_copy.sh"
)"

while read -r _files_copy_line; do
	_src_file_path="$_program_path/files/$(basename "$_files_copy_line")"

	if [ ! -r "$_src_file_path" ]; then
		printf "%s\n%s\n%s\n\n" \
            "Source file not found. Can't copy" \
            "Source: $(_style "$_src_file_path" $_underline)" \
            "To:     $(_style "$_files_copy_line" $_underline)" 
		continue
	fi

    _target_file_path="$_files_copy_line"
	_target_file_name="$(basename "$_target_file_path")"
	
	if [ -r "$_target_file_path" ] || [ -L "$_target_file_path" ]; then
		if _confirm "File $(_style "$_target_file_name" $_underline) already exists. Back it up and overwrite it?" "n"; then
			_backup_dir="$_program_path/backup"
			_backup_file_path="$_backup_dir/$_target_file_name"
			
			mkdir -p "$_backup_dir"
            if cp "$_target_file_path" "$_backup_file_path"; then
                :
            else
                printf "Backup failed. Aborting copy overwrite $(_style "$_target_file_path" $_underline)\n\n"
                continue
            fi
		else
			printf "Aborting copy overwrite $(_style "$_target_file_path" $_underline)\n\n"
			continue
		fi
	fi

    printf "%s\n%s\n\n" \
    "Copying: $_src_file_path" \
    "To:      $_target_file_path"

    if cat "$_src_file_path" > "$_target_file_path"; then
        printf "Success copying: $(_style "$_target_file_name" $_underline)\n\n"
    else
        cat "$_backup_file_path" > "$_target_file_path"
        printf "Failed copying: $(_style "$_target_file_name" $_underline)\n\n"
    fi

done <<< "$_files_copy_output"

