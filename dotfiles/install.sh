#!/usr/bin/env bash
_dotfiles_script_source="$(cd "$(dirname "$BASH_SOURCE")"; pwd)"
_dotfiles_env_run="$_dotfiles_script_source/.dotfiles_env_run.sh"
# shellcheck source=SCRIPTDIR/.dotfiles_env_run.sh
. $_dotfiles_env_run

_selected_program_name=''

_programs_dir="$_DOTFILES_DIR/programs"

_create_menu_selection _selected_program_name < <(
    while IFS= read -r _program_name; do
        printf '%s\n' "$_program_name" 
        xargs -I %% printf '    > %s\n' '%%' < <(ls -l1 "$_programs_dir/$_program_name" | _grep_filter -E ^install)
    done < <(ls -l1 "$_programs_dir"/)
)

# "$_DOTFILES_DIR/programs"
