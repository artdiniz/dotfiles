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

_files_link_output="$(
    "$_program_path/files_link.sh"
)"

while read -r _file_link_line; do
    
    _link_path="$_file_link_line"
    _link_dirname="$(dirname "$_link_path")"
    _link_name="$(basename "$_link_path")"
    _src_file_path="$_program_path/files/$_link_name"

	if [ ! -r "$_src_file_path" ]; then
		printf "%s\n%s\n%s\n\n" \
            "Source file not found. Can't link." \
            "Source: $(_style "$_src_file_path" $_underline)" \
            "To:     $(_style "$_link_path" $_underline)"
		continue
	fi

    if [ -r "$_link_path" ] || [ -L "$_link_path" ]; then
        if _confirm "File $(_style "$_link_name" $_underline) already exists. Back it up and overwrite it?" "n"; then
            _backup_dir="$_program_path/backup"
            _backup_file_path="$_backup_dir/$_link_name"
            
            mkdir -p "$_backup_dir"
            if mv "$_link_path" "$_backup_file_path"; then
                :
            else
                printf "Backup failed. Aborting link overwrite $(_style "$_link_path" $_underline)\n\n"
                continue
            fi
        else
            printf "Aborting link overwrite $(_style "$_link_path" $_underline)\n\n"
            continue
        fi
    fi

    printf "%s\n%s\n\n" \
        "Source: $_src_file_path" \
        "To:     $_link_path"
    
    if ln -s "$_src_file_path" "$_link_path"; then
        printf "Success linking: $(_style "$_link_name" $_underline)\n\n"
    else
        cat "$_backup_file_path" > "$_link_path"
        printf "Failed linking: $(_style "$_link_name" $_underline)\n\n"
    fi

done <<< "$(printf "%s\n" "$_files_link_output")"
