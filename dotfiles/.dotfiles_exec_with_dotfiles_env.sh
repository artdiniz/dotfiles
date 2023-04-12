#!/usr/bin/env bash
_script_relative_path="$1"

_dotfiles_env_file="$(cd "$(dirname "$BASH_SOURCE")"; pwd)/.dotfiles_env.sh"
. "$_dotfiles_env_file"

/usr/bin/env bash -c "BASH_ENV=$_dotfiles_env_file $_DOTFILES_DIR/$_script_relative_path ${@:2}" $_DOTFILES_DIR/$_script_relative_path

exit $?
