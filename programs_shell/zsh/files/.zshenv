# https://scriptingosx.com/2019/06/moving-to-zsh-part-2-configuration-files/
###############################################################################
#                                                                             #
#                YOU SHALL NOT TOUCH THIS FILE!                               #                      #
#                  FOR MORE RELIABLE SCRIPTS EXECUTION                        #
#                                                                             #
#           You may want to edit ".shell_env_global_setup" instead            #
#                                                                             #
###############################################################################

_SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"
_dotfiles_path="$HOME/dotfiles"
_dotfiles_shell_env_scripts_path="$_dotfiles_path/dotfiles/shell_env"

source "$_dotfiles_shell_env_scripts_path/.shell_env_global_setup"
