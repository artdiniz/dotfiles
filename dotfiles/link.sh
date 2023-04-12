#!/usr/bin/env bash

_SCRIPT_DIR="$(cd "$(dirname "$BASH_SOURCE")"; pwd)"
_dotfiles_env_file="$_SCRIPT_DIR/.dotfiles_env.sh"

# shellcheck source=SCRIPTDIR/.dotfiles_env.sh
source "$_dotfiles_env_file"

_program_name="$1"

if [ -d "programs/$_program_name" ]; then
    _program_path="programs/$_program_name"
fi

if [ -d "programs_shell/$_program_name" ]; then
    _program_path="programs_shell/$_program_name"
fi

_links="$(
    "$_SCRIPT_DIR"/.dotfiles_exec_with_dotfiles_env.sh "$_program_path/link.sh"
)"

while read -r _link_path; do
    _link_dirname="$(dirname "$_link_path")"
    _link_name="$(basename "$_link_path")"

    _file_path="$_DOTFILES_DIR/$_program_path/files/$_link_name"

    if [ -r "$_link_path" ] || [ -L "$_link_path" ]; then
        if _confirm "File $(_style "$_link_name" $_underline) already exists. Back it up and overwrite it?" "n"; then
            _backup_dir="$_DOTFILES_DIR/$_program_path/backup"
            _backup_file_path="$_backup_dir/$_link_name"
            
            mkdir -p "$_backup_dir"
            mv "$_link_path" "$_backup_file_path"
        else
            printf "Aborting link overwrite $(_style "$_link_path" $_underline)\n\n"
            continue
        fi
    fi

    if [ -r "$_file_path" ]; then
        printf "%s\n%s\n\n" \
            "Linking: $_file_path" \
            "To:      $_link_path"
        
        if ln -s "$_file_path" "$_link_path"; then
            printf "Success linking: $(_style "$_link_name" $_underline)\n\n"
        else
            printf "Failed linking: $(_style "$_link_name" $_underline)\n\n"
        fi
    else
        printf "%s\n\n" "Not found. Can't link '$_file_path'"
    fi

done <<< "$(printf "%s\n" "$_links")"
