###############################################################################
#  YOU SHALL NOT TOUCH THIS FILE!                                             #
#                                                                             #
#  Instead use one of those "shell_env_*" files                            #
#      .shell_env_global_setup                                                #
#      .shell_env_terminal_setup                                              #
###############################################################################

_SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"
_dotfiles_path="$HOME/dotfiles"
_dotfiles_shell_env_scripts_path="$_dotfiles_path/dotfiles/shell_env"
_dotfiles_shell_name="zsh"

source "$_dotfiles_shell_env_scripts_path/.shell_env_global_setup"

# We are in an interactive shell
# Run user terminal applicaton setup
source "$_dotfiles_shell_env_scripts_path/.shell_env_terminal_setup"