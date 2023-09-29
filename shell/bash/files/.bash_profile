###############################################################################
#  YOU SHALL NOT TOUCH THIS FILE!                                             #
#                                                                             #
#  Instead use one of those "shell_env_*" files                               #
#      .shell_env_global_setup                                                #
#      .shell_env_login_setup                                                 #
#      .terminal_env_programs_setup                                           #
###############################################################################

# https://www.gnu.org/software/bash/manual/bash.html#Bash-Startup-Files

_dotfiles_path="$HOME/dotfiles"
_dotfiles_shell_env_scripts_path="$_dotfiles_path/.src/shell_env"
_dotfiles_shell_name="bash"

# BASH_ENV for non interactive shells
BASH_ENV="$_dotfiles_path/shell/bash/files/.bashenv"

source "$_dotfiles_shell_env_scripts_path/.shell_env_global_setup"

source "$_dotfiles_shell_env_scripts_path/.shell_env_login_setup"

source "$_dotfiles_shell_env_scripts_path/.terminal_env_programs_setup"
