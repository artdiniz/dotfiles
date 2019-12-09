###############################################################################
#  YOU SHALL NOT TOUCH THIS FILE!                                             #
#                                                                             #
#  Instead use one of those "shell_env_*" files                               #
#      ../.shell_env_global_setup                                                #
#      ../.shell_env_login_setup                                                 #
#      ../.shell_env_terminal_setup                                              #
###############################################################################

BASH_ENV=".bashscriptsonlyrc"

. ../.shell_env_global_setup

# login shell environment
. ../.shell_env_login_setup

# If we are in an interactive shell
case "$-" in 
    *i*)
        # Run user terminal applicaton setup
        . ../.shell_env_terminal_setup
    ;;
esac