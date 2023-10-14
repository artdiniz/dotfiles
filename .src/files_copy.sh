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


_copies="$(
    "$_program_path/files_copy.sh"
)"

while read -r _target_file_path; do
    _target_json_prop_path=""
    if [ "$_target_file_path" != "${_target_file_path%%.json}" ]; then
    
        _target_json_file_path="$(_json_utils get_filename "$_target_file_path" )"
        _target_json_prop_path="$(_json_utils get_fileproppath "$_target_file_path" )"

        _target_file_name="$(basename "$_target_json_file_path")"
        _src_file_path="$_program_path/files/$(basename "$_target_file_path")"
        _target_file_path="$_target_json_file_path"
    else
        _target_file_name="$(basename "$_target_file_path")"
        _src_file_path="$_program_path/files/$_target_file_name"
    fi

    
    if [ -r "$_target_file_path" ] || [ -L "$_target_file_path" ]; then
        if _confirm "File $(_style "$_target_file_name" $_underline) already exists. Back it up and overwrite it?" "n"; then
            _backup_dir="$_program_path/backup"
            _backup_file_path="$_backup_dir/$_target_file_name"
            
            mkdir -p "$_backup_dir"
            cp "$_target_file_path" "$_backup_file_path"
        else
            printf "Aborting link overwrite $(_style "$_target_file_path" $_underline)\n\n"
            continue
        fi
    fi

    if [ -r "$_src_file_path" ] && [ -z "$_target_json_prop_path" ]; then
        printf "%s\n%s\n\n" \
            "Copying: $_src_file_path" \
            "To:      $_target_file_path"
        
        if cat "$_src_file_path" > "$_target_file_path"; then
            printf "Success copying: $(_style "$_target_file_name" $_underline)\n\n"
        else
            cat "$_backup_file_path" > "$_target_file_path"
            printf "Failed copying: $(_style "$_target_file_name" $_underline)\n\n"
        fi

    elif [ -r "$_src_file_path" ] && [ ! -z "$_target_json_prop_path" ]; then
        _log printf "%s\n%s\n%s\n\n" \
            "Copying JSON:  $_src_file_path" \
            "To JSON prop:  $_target_json_prop_path" \
            "To file:       $_target_file_path"


        # cat "$_target_file_path" > "$_backup_file_path.original.json"
        # _json_utils read "$(cat "$_target_file_path")" > "$_backup_file_path.read.json"

        if _json_utils write "$(cat "$_target_file_path")" "$_target_json_prop_path" "$(cat "$_src_file_path")" > "$_target_file_path"; then
            printf "Success copying: $(_style "$_target_file_name" $_underline)\n\n"
        else
            cat "$_backup_file_path" > "$_target_file_path"
            printf "Failed copying: $(_style "$_target_file_name" $_underline)\n\n"
        fi
    else
        printf "%s\n\n" "Not found. Can't link '$_src_file_path'"
    fi

done <<< "$(printf "%s\n" "$_copies")"
