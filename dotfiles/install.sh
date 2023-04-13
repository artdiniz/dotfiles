#!/usr/bin/env bash
_SCRIPT_DIR="$(cd "$(dirname "$BASH_SOURCE")"; pwd)"
_dotfiles_env_file="$_SCRIPT_DIR/.dotfiles_env.sh"

# shellcheck source=SCRIPTDIR/.dotfiles_env.sh
source "$_dotfiles_env_file"

set -u 

_selected_program_name=''

_programs_dir="$_SCRIPT_DIR/../programs"

_create_menu_selection _selected_program_name < <(
    while IFS= read -r _program_name; do
        printf '%s\n' "$_program_name" 
        xargs -I %% printf '    > %s\n' '%%' < <(ls -l1 "$_programs_dir/$_program_name" | _grep_filter -E ^install)
    done < <(ls -l1 "$_programs_dir"/)
)

# "$_SCRIPT_DIR"/.dotfiles_exec_with_dotfiles_env.sh "$_DOTFILES_DIR/programs"
