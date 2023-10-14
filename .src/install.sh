#!/usr/bin/env bash
_dotfiles_script_source="$(cd "$(dirname "$BASH_SOURCE")"; pwd)"
"$_dotfiles_script_source/.dotfiles_run_prefixed.sh" install $@

