#!/usr/bin/env bash
_dotfiles_script_source="$(cd "$(dirname "$BASH_SOURCE")"; pwd)"
_dotfiles_env_run="$_dotfiles_script_source/.dotfiles_env_run.sh"
# shellcheck source=SCRIPTDIR/.dotfiles_env_run.sh
. $_dotfiles_env_run

_scripts_prefix="$1"
_program_name="$2"


_program_path="$_program_name"

if [ -d "$_program_path" ]; then
    _program_path="$(cd "$_program_path"; pwd)"
elif [ -d "$_DOTFILES_DIR/programs/$_program_path" ]; then
    _program_path="$_DOTFILES_DIR/programs/$_program_path"
elif [ -d "$_DOTFILES_DIR/shell/$_program_path" ]; then
    _program_path="$_DOTFILES_DIR/shell/$_program_path"
else
    printf "Unknown program $_program_path\n\n"
    exit 1
fi


_program_relative_path="${_program_path##$_DOTFILES_DIR/}"

if [ "$_program_relative_path" == "$_program_path" ]; then
	printf "Not a dotfiles program: $_program_path\n\n"
    exit 1
fi

_prefixed_scripts="$(
	for file in $(ls -l1 "$_program_path"); do
		if _string_starts_with "$file" "$_scripts_prefix"; then
			echo "$_program_relative_path/$file"
		fi
	done
)"

_selected_scripts="$(_select "Select which scripts you want to run" "$_prefixed_scripts")"

for file in $_selected_scripts; do
	echo "Running $file"
	"$_DOTFILES_DIR/$file"
done
