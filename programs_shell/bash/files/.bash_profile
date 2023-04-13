###############################################################################
#  YOU SHALL NOT TOUCH THIS FILE!                                             #
#                                                                             #
#  Instead use one of those "shell_env_*" files                               #
#      .shell_env_global_setup                                                #
#      .shell_env_login_setup                                                 #
#      .shell_env_terminal_setup                                              #
###############################################################################

_SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"
_dotfiles_path="$HOME/dotfiles"
_dotfiles_shell_env_scripts_path="$_dotfiles_path/dotfiles/shell_env"
_dotfiles_shell_name="bash"

BASH_ENV="$_dotfiles_path/programs_shell/bash/files/.bashenv"

source "$_dotfiles_shell_env_scripts_path/.shell_env_global_setup"

# login shell environment
source "$_dotfiles_shell_env_scripts_path/.shell_env_login_setup"

# If we are in an interactive shell
case "$-" in 
    *i*)
        # Run user terminal applicaton setup
        source "$_dotfiles_shell_env_scripts_path/.shell_env_terminal_setup"
    ;;
esac