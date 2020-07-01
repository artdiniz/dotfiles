#!/usr/bin/env bash
set -u

_SCRIPT_DIR="$(cd "$(dirname "$BASH_SOURCE")"; pwd)"
_program_name="$1"

"$_SCRIPT_DIR"/.dotfiles_exec_with_dotfiles_env.sh "programs/$_program_name/postinstall.sh"
