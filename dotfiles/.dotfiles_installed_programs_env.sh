# TODO source based on the same pattern as in `_shell_env_by_lifecycle_and_scope`scripts

#!/usr/bin/env bash
set -u

_SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"
_programs_dir="$(cd "$_SCRIPT_DIR/../programs"; pwd)"

_private_env_file_name=".private_shell_env"
_public_env_file_name=".shell_env"

while IFS= read -r _program_name; do
    _private_env_file="$_programs_dir/$_program_name/$_private_env_file_name"
    _public_env_file="$_programs_dir/$_program_name/$_public_env_file_name"

    if [ -r "$_public_env_file" ]; then
        source "$_public_env_file"
    fi

    if [ -r "$_private_env_file" ]; then
        source "$_private_env_file"
    fi
done <<< "$(ls -l1 "$_programs_dir")"