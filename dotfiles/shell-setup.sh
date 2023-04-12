#!/usr/bin/env bash

_SCRIPT_DIR="$(cd "$(dirname "$BASH_SOURCE")"; pwd)"

for _folder_path in $(ls -dl1 $_SCRIPT_DIR/shell-setup/*/); do
    _folder_name="$(basename "$_folder_path")"
    for _setup_file_name in $(ls -lA1 $_folder_path); do
        echo "=== $_setup_file_name"
    done
done
