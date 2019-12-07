#!/usr/bin/env bash

_dotfiles_env_file="$(cd "$(dirname "$BASH_SOURCE")"; pwd)/.dotfiles_env.sh"

# shellcheck source=SCRIPTDIR/.dotfiles_env.sh
source "$_dotfiles_env_file"

set -u

_program_name="$1"

/usr/bin/env bash -c "BASH_ENV="$_dotfiles_env_file" $_DOTFILES_DIR/programs/$_program_name/postinstall.sh" "$_DOTFILES_DIR/programs/$_program_name/postinstall.sh"
