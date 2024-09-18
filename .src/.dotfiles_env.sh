#!/usr/bin/env bash

export _DOTFILES_HAS_ENV=1
_DOTFILES_DIR="$(test ! -z "$_DOTFILES_DIR" && printf "$_DOTFILES_DIR" || CDPATH= cd -- "$(dirname -- "$DOTFILES_ENV_FILE")/.." && pwd)"
_DOTFILES_PRIVATE_ENV_FILE=".shell_env_private"

# echo "=== BASH ENV RUN BASH_SOURCE[${BASH_SOURCE[@]}] \$0[$0] \$@[$@]"

# shellcheck source=SCRIPTDIR/lib/view/error_handling/_setup_error_handling.sh
. "$_DOTFILES_DIR"/.src/lib/error_handling/_setup_error_handling.sh

# shellcheck source=SCRIPTDIR/lib/infra/_path_utils.sh
. "$_DOTFILES_DIR"/.src/lib/infra/_path_utils.sh

# shellcheck source=SCRIPTDIR/lib/infra/_json_utils.sh
. "$_DOTFILES_DIR"/.src/lib/infra/_json_utils.sh

# shellcheck source=SCRIPTDIR/lib/infra/_string_utils.sh
. "$_DOTFILES_DIR"/.src/lib/infra/_string_utils.sh

# shellcheck source=SCRIPTDIR/lib/infra/_function_utils.sh
. "$_DOTFILES_DIR"/.src/lib/infra/_function_utils.sh

# shellcheck source=SCRIPTDIR/lib/infra/_create_string_var.sh
. "$_DOTFILES_DIR"/.src/lib/infra/_create_string_var.sh

# shellcheck source=SCRIPTDIR/lib/infra/_grep.sh
. "$_DOTFILES_DIR"/.src/lib/infra/_grep.sh

# shellcheck source=SCRIPTDIR/lib/view/_box.sh
. "$_DOTFILES_DIR"/.src/lib/view/_box.sh

# shellcheck source=SCRIPTDIR/lib/view/_log.sh
. "$_DOTFILES_DIR"/.src/lib/view/_log.sh

# shellcheck source=SCRIPTDIR/lib/view/_prompt_and_confirm.sh
. "$_DOTFILES_DIR"/.src/lib/view/_prompt_and_confirm.sh

# shellcheck source=SCRIPTDIR/lib/view/_confirm.sh
. "$_DOTFILES_DIR"/.src/lib/view/_confirm.sh

# shellcheck source=SCRIPTDIR/lib/view/_render.sh
. "$_DOTFILES_DIR"/.src/lib/view/_render.sh

# shellcheck source=SCRIPTDIR/lib/view/_select.sh
. "$_DOTFILES_DIR"/.src/lib/view/_select.sh

# shellcheck source=SCRIPTDIR/lib/view/_style.sh
. "$_DOTFILES_DIR"/.src/lib/view/_style.sh

# shellcheck source=SCRIPTDIR/lib/os_detection/is_get_os.sh
. "$_DOTFILES_DIR"/.src/lib/os_detection/is_get_os.sh

# shellcheck source=SCRIPTDIR/lib/file_system/_create_and_write_file.sh
. "$_DOTFILES_DIR"/.src/lib/file_system/_create_and_write_file.sh

# shellcheck source=SCRIPTDIR/lib/file_system/_parse_to_path_with_tilde.sh
. "$_DOTFILES_DIR"/.src/lib/file_system/_parse_to_path_with_tilde.sh
