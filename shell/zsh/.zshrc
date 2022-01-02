###############################################################################
#  YOU SHALL NOT TOUCH THIS FILE!                                             #
#                                                                             #
#  Instead use one of those "../shell_env/*" files                            #
#      .shell_env_global_setup                                                #
#      .shell_env_terminal_setup                                              #
###############################################################################

# BASH_ENV=".bashscriptsonlyrc"


_SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"
_dotfiles_shell_path="$HOME/dotfiles/shell"
_dotfiles_shell_env_scripts_path="$_dotfiles_shell_path/_shell_env"

source "$_dotfiles_shell_env_scripts_path/.shell_env_global_setup"

# We are in an interactive shell
# Run user terminal applicaton setup
source "$_dotfiles_shell_env_scripts_path/.shell_env_terminal_setup"
