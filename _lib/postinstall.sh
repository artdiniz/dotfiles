#!/usr/bin/env bash
_dotfiles_script_source="$(cd "$(dirname "$BASH_SOURCE")"; pwd)"
"$_dotfiles_script_source/_run.sh" postinstall $@

