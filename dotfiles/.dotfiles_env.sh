#!/usr/bin/env bash

# This file is used as BASH_ENV on all/most of dotfiles commands
#     this means that this script is executed on each child script call
#     this behavior is important for stack tracing in _setup_error_handling.sh and will probably be useful in other places too

export _DOTFILES_HAS_ENV=1
_DOTFILES_DIR="$(
    test -z "$_DOTFILES_DIR" && printf "$HOME/dotfiles" || printf "$_DOTFILES_DIR"
)"
_DOTFILES_PRIVATE_ENV_FILE=".shell_env_private"
_SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"
# echo "=== BASH ENV RUN BASH_SOURCE[${BASH_SOURCE[@]}] \$0[$0] \$@[$@]"


# shellcheck source=SCRIPTDIR/lib/view/error_handling/_setup_error_handling.sh
. "$_DOTFILES_DIR"/dotfiles/lib/error_handling/_setup_error_handling.sh

# shellcheck source=SCRIPTDIR/lib/infra/_string_utils.sh
. "$_DOTFILES_DIR"/dotfiles/lib/infra/_string_utils.sh

# shellcheck source=SCRIPTDIR/lib/infra/_function_utils.sh
. "$_DOTFILES_DIR"/dotfiles/lib/infra/_function_utils.sh

# shellcheck source=SCRIPTDIR/lib/infra/_create_string_var.sh
. "$_DOTFILES_DIR"/dotfiles/lib/infra/_create_string_var.sh

# shellcheck source=SCRIPTDIR/lib/infra/_grep.sh
. "$_DOTFILES_DIR"/dotfiles/lib/infra/_grep.sh

# shellcheck source=SCRIPTDIR/lib/view/_box.sh
. "$_DOTFILES_DIR"/dotfiles/lib/view/_box.sh

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

# shellcheck source=SCRIPTDIR/lib/file_system/_parse_to_path_with_tilde.sh
. "$_DOTFILES_DIR"/dotfiles/lib/file_system/_parse_to_path_with_tilde.sh
