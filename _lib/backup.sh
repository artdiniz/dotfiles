#!/usr/bin/env bash
_dotfiles_script_source="$(cd "$(dirname "$BASH_SOURCE")"; pwd)"
_dotfiles_env_run="$_dotfiles_script_source/.dotfiles_env_run.sh"
# shellcheck source=SCRIPTDIR/.dotfiles_env_run.sh
. $_dotfiles_env_run

_program_name="$1"

"$_DOTFILES_DIR/programs/$_program_name/backup.sh"
