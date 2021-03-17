#!/usr/bin/env bash

_SCRIPT_DIR="$(cd "$(dirname "$BASH_SOURCE")"; pwd)"
_program_name="$1"

for file in $(ls -l1 "programs/$_program_name"); do
    if _string_starts_with "$file" "postinstall"; then
        echo "$file"
        "$_SCRIPT_DIR"/.dotfiles_exec_with_dotfiles_env.sh "programs/$_program_name/$file"
    fi
done
