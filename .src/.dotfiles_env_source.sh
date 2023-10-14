# source this file on any script you want to be run with dotfiles env

#!/usr/bin/env bash
_dotfiles_env_file="$(cd "$(dirname "$BASH_SOURCE")"; pwd)/.dotfiles_env.sh"

if [  -z "${_DOTFILES_HAS_ENV:-}" ]; then
    /usr/bin/env bash -c "BASH_ENV=$_dotfiles_env_file \$0 \$@" $0 $@
    exit $?
fi
