#!/usr/bin/env bash

_dotfiles_env_file="$(cd "$(dirname "$BASH_SOURCE")"; pwd)/.dotfiles_env.sh"

# shellcheck source=SCRIPTDIR/.dotfiles_env.sh
source "$_dotfiles_env_file"

set -u

_program_name="$1"

_links="$(
    /usr/bin/env bash -c "BASH_ENV=$_dotfiles_env_file $_DOTFILES_DIR/programs/$_program_name/link.sh" "$_DOTFILES_DIR/programs/$_program_name/link.sh"
)"

while read -r _link_path; do
    _link_dirname="$(dirname "$_link_path")"
    _link_name="$(basename "$_link_path")"

    _file_path="$_DOTFILES_DIR/programs/$_program_name/files/$_link_name"

    if [ -r "$_file_path" ]; then
        printf "%s\n%s\n\n" \
            "Linking: $_file_path" \
            "To:      $_link_path"

        ln -s "$_file_path" "$_link_path"

        if [ $? -eq 0 ]; then
            printf "Success linking: $(_style "$_link_name" $_underline)\n\n"
        else
            printf "Failed linking: $(_style "$_link_name" $_underline)\n\n"
        fi
    else
        printf "%s\n\n" "Not found. Can't link '$_file_path'"
    fi

done <<< "$(printf "%s\n" "$_links")"
