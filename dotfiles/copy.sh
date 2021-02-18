#!/usr/bin/env bash

_SCRIPT_DIR="$(cd "$(dirname "$BASH_SOURCE")"; pwd)"
_dotfiles_env_file="$_SCRIPT_DIR/.dotfiles_env.sh"

# shellcheck source=SCRIPTDIR/.dotfiles_env.sh
source "$_dotfiles_env_file"

set -u

_program_name="$1"

_links="$(
    "$_SCRIPT_DIR"/.dotfiles_exec_with_dotfiles_env.sh "programs/$_program_name/copy.sh"
)"

while read -r _copy_path; do
    _copy_dirname="$(dirname "$_copy_path")"
    _copy_name="$(basename "$_copy_path")"

    _file_path="$_DOTFILES_DIR/programs/$_program_name/files/$_copy_name"

    if [ -r "$_file_path" ]; then
        printf "%s\n%s\n\n" \
            "Copying: $_file_path" \
            "To:      $_copy_path"

        cp "$_file_path" "$_copy_path"

        if [ $? -eq 0 ]; then
            printf "Success copying: $(_style "$_copy_name" $_underline)\n\n"
        else
            printf "Failed copying: $(_style "$_copy_name" $_underline)\n\n"
        fi
    else
        printf "%s\n\n" "Not found. Can't link '$_file_path'"
    fi

done <<< "$(printf "%s\n" "$_links")"
