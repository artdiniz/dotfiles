###############################################################################
#  YOU SHALL NOT TOUCH THIS FILE!                                             #
#                                                                             #
#  Instead use one of those "shell_env_*" files                               #
#      .shell_env_global_setup                                                #
#      .shell_env_login_setup                                                 #
#      .terminal_env_programs_setup                                              #
###############################################################################

_dotfiles_path="$HOME/dotfiles"
_dotfiles_shell_env_scripts_path="$_dotfiles_path/_lib/shell_env"
_dotfiles_shell_name="zsh"

# login shell environment
source "$_dotfiles_shell_env_scripts_path/.shell_env_login_setup"
