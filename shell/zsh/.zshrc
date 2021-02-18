###############################################################################
#  YOU SHALL NOT TOUCH THIS FILE!                                             #
#                                                                             #
#  Instead use one of those "shell_env_*" files                               #
#      ../.shell_env_global_setup                                                #
#      ../.shell_env_terminal_setup                                              #
###############################################################################

# BASH_ENV=".bashscriptsonlyrc"


_SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"
_dotfiles_shell_path="$HOME/dotfiles/shell"

source "${_dotfiles_shell_path}/.shell_env_global_setup"

if [ -r "${_dotfiles_shell_path}/.shell_env_global_setup.zsh" ]; then
    source "${_dotfiles_shell_path}/.shell_env_global_setup.zsh"
fi

# We are in an interactive shell
# Run user terminal applicaton setup
source "${_dotfiles_shell_path}/.shell_env_terminal_setup"

if [ -r "${_dotfiles_shell_path}/.shell_env_terminal_setup.zsh" ]; then
    source "${_dotfiles_shell_path}/.shell_env_terminal_setup.zsh"
fi