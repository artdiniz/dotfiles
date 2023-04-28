###############################################################################
#  YOU SHALL NOT TOUCH THIS FILE!                                             #
#                                                                             #
#  Instead use one of those "shell_env_*" files                            #
#      .shell_env_global_setup                                                #
#      .shell_env_terminal_setup                                              #
###############################################################################

_dotfiles_path="$HOME/dotfiles"
_dotfiles_shell_env_scripts_path="$_dotfiles_path/_lib/shell_env"
_dotfiles_shell_name="bash"

BASH_ENV="$_dotfiles_path/programs_shell/bash/files/.bashenv"

source "$_dotfiles_shell_env_scripts_path/.shell_env_global_setup"

# We are in an interactive shell
# Run user terminal applicaton setup
source "$_dotfiles_shell_env_scripts_path/.shell_env_terminal_setup"
