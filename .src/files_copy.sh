#!/usr/bin/env bash
_dotfiles_script_source="$(cd "$(dirname "$BASH_SOURCE")"; pwd)"
_dotfiles_env_run="$_dotfiles_script_source/.dotfiles_env_run.sh"
# shellcheck source=SCRIPTDIR/.dotfiles_env_run.sh
. $_dotfiles_env_run

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

while read -r _copy_path; do
    _link_dirname="$(dirname "$_copy_path")"
    _link_name="$(basename "$_copy_path")"

    _file_path="$_program_path/files/$_link_name"

    if [ -r "$_copy_path" ] || [ -L "$_copy_path" ]; then
        if _confirm "File $(_style "$_link_name" $_underline) already exists. Back it up and overwrite it?" "n"; then
            _backup_dir="$_program_path/backup"
            _backup_file_path="$_backup_dir/$_link_name"
            
            mkdir -p "$_backup_dir"
            mv "$_copy_path" "$_backup_file_path"
        else
            printf "Aborting link overwrite $(_style "$_copy_path" $_underline)\n\n"
            continue
        fi
    fi

    if [ -r "$_file_path" ]; then
        printf "%s\n%s\n\n" \
            "Copying: $_file_path" \
            "To:      $_copy_path"
        
        if cp "$_file_path" "$_copy_path"; then
            printf "Success copying: $(_style "$_link_name" $_underline)\n\n"
        else
            printf "Failed copying: $(_style "$_link_name" $_underline)\n\n"
        fi
    else
        printf "%s\n\n" "Not found. Can't link '$_file_path'"
    fi

done <<< "$(printf "%s\n" "$_copies")"
