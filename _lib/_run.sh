#!/usr/bin/env bash
_dotfiles_script_source="$(cd "$(dirname "$BASH_SOURCE")"; pwd)"
_dotfiles_env_run="$_dotfiles_script_source/.dotfiles_env_run.sh"
# shellcheck source=SCRIPTDIR/.dotfiles_env_run.sh
. $_dotfiles_env_run

_scripts_prefix="$1"
_script_relative_path="$2"

_prefixed_scripts="$(
	for file in $(ls -l1 "$_DOTFILES_DIR/$_script_relative_path"); do
		if _string_starts_with "$file" "$_scripts_prefix"; then
			echo "$_script_relative_path/$file"
		fi
	done
)"

_selected_scripts="$(_select "Select which scripts you want to run" "$_prefixed_scripts")"

for file in $_selected_scripts; do
	echo "Running $file"
	"$_DOTFILES_DIR/$file"
done
