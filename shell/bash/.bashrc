###############################################################################
#  YOU SHALL NOT TOUCH THIS FILE!                                             #
#                                                                             #
#  Instead use one of those "shell_env_*" files                               #
#      ../.shell_env_global_setup                                                #
#      ../.shell_env_terminal_setup                                              #
###############################################################################

BASH_ENV=".bashscriptsonlyrc"

_shell_specific_file_extension="bash"

source "../.shell_env_global_setup"

if [ -r "../.shell_env_global_setup.${_shell_specific_file_extension}" ]; then
    source "../.shell_env_global_setup.${_shell_specific_file_extension}"
fi

# We are in an interactive shell
# Run user terminal applicaton setup

source "../.shell_env_terminal_setup"

if [ -r "../.shell_env_terminal_setup.${_shell_specific_file_extension}" ]; then
    source "../.shell_env_terminal_setup.${_shell_specific_file_extension}"
fi