#!/usr/bin/env bash
# Source this file on any script you want to have dotfiles env
# This scripts sets BASH_ENV to .dotfiles_env.sh and then reruns the script that sourced it
#     this means that .dotfiles_env.sh is sourced on each child call
#     this child call behavior is important for stack tracing in _setup_error_handling.sh

_dotfiles_env_file="$(cd "$(dirname "$BASH_SOURCE")"; pwd)/.dotfiles_env.sh"

if [  -z "${_DOTFILES_HAS_ENV:-}" ]; then
    /usr/bin/env bash -c "BASH_ENV=$_dotfiles_env_file \$0 \$@" $0 $@
    exit $?
fi
