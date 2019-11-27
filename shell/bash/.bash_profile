###############################################################################
#  YOU SHALL NOT TOUCH THIS FILE!                                             #
#                                                                             #
#  Instead use one of those "shell_*_env" files                               #
#      .shell_global_env_setup                                                #
#      .shell_login_env_setup                                                 #
#      .shell_terminal_env_setup                                              #
###############################################################################

BASH_ENV=".bashscriptsonlyrc"

source .shell_global_env_setup

# login shell environment
source .shell_login_env_setup

# If we are in an interactive shell
case "$-" in 
    *i*)
        # Run user terminal applicaton setup
        . .shell_terminal_env_setup
    ;;
esac