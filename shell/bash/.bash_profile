###############################################################################
#  YOU SHALL NOT TOUCH THIS FILE!                                             #
#                                                                             #
#  Instead use one of those "shell_env_*" files                               #
#      ../.shell_env_global_setup                                                #
#      ../.shell_env_login_setup                                                 #
#      ../.shell_env_terminal_setup                                              #
###############################################################################

BASH_ENV=".bashscriptsonlyrc"

_shell_specific_file_extension="bash"

if [ -r "../.shell_env_global_setup" ]; then
    source "../.shell_env_global_setup"
fi

if [ -r "../.shell_env_global_setup.${_shell_specific_file_extension}" ]; then
    source "../.shell_env_global_setup.${_shell_specific_file_extension}"
fi

# login shell environment
if [ -r "../.shell_env_login_setup" ]; then
    source "../.shell_env_login_setup"
fi

if [ -r "../.shell_env_login_setup.${_shell_specific_file_extension}" ]; then
    source "../.shell_env_login_setup.${_shell_specific_file_extension}"
fi

# If we are in an interactive shell
case "$-" in 
    *i*)
        # Run user terminal applicaton setup
        if [ -r "../.shell_env_terminal_setup" ]; then
            source "../.shell_env_terminal_setup"
        fi

        if [ -r "../.shell_env_terminal_setup.${_shell_specific_file_extension}" ]; then
            source "../.shell_env_terminal_setup.${_shell_specific_file_extension}"
        fi
    ;;
esac