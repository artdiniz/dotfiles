#!/usr/bin/env bash

_DOTFILES_DIR="$(
    test -z "$_DOTFILES_DIR" && printf "$HOME/dotfiles" || printf "$_DOTFILES_DIR"
)"
_DOTFILES_PRIVATE_ENV_FILE=".private_shell_env"
_SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"

# shellcheck source=SCRIPTDIR/lib/view/error_handling/_setup_error_handling.sh
. "$_DOTFILES_DIR"/dotfiles/lib/error_handling/_setup_error_handling.sh

# shellcheck source=SCRIPTDIR/lib/infra/_create_string_var.sh
. "$_DOTFILES_DIR"/dotfiles/lib/infra/_create_string_var.sh

# shellcheck source=SCRIPTDIR/lib/infra/_c1_grep.sh
. "$_DOTFILES_DIR"/dotfiles/lib/infra/_c1_grep.sh

# shellcheck source=SCRIPTDIR/lib/view/_box.sh
. "$_DOTFILES_DIR"/dotfiles/lib/view/_box/_box.sh

# shellcheck source=SCRIPTDIR/lib/view/_prompt_and_confirm.sh
. "$_DOTFILES_DIR"/dotfiles/lib/view/_prompt_and_confirm.sh

# shellcheck source=SCRIPTDIR/lib/view/_create_menu_selection.sh
. "$_DOTFILES_DIR"/dotfiles/lib/view/_create_menu_selection.sh

# shellcheck source=SCRIPTDIR/lib/view/_confirm.sh
. "$_DOTFILES_DIR"/dotfiles/lib/view/_confirm.sh

# shellcheck source=SCRIPTDIR/lib/view/_render.sh
. "$_DOTFILES_DIR"/dotfiles/lib/view/_render.sh

# shellcheck source=SCRIPTDIR/lib/view/_style.sh
. "$_DOTFILES_DIR"/dotfiles/lib/view/_style.sh

# shellcheck source=SCRIPTDIR/lib/os_detection/is_get_os.sh
. "$_DOTFILES_DIR"/dotfiles/lib/os_detection/is_get_os.sh

# shellcheck source=SCRIPTDIR/lib/file_system/_create_and_write_file.sh
. "$_DOTFILES_DIR"/dotfiles/lib/file_system/_create_and_write_file.sh

# shellcheck source=SCRIPTDIR/lib/file_system/_get_path_with_tilde.sh
. "$_DOTFILES_DIR"/dotfiles/lib/file_system/_get_path_with_tilde.sh

# shellcheck source=SCRIPTDIR/lib/file_system/_get_scriptdir.sh
. "$_DOTFILES_DIR"/dotfiles/lib/file_system/_get_scriptdir.sh
