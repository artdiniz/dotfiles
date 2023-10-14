#!/usr/bin/env bash
_dotfiles_src_dir="$(cd "$(dirname "$BASH_SOURCE")"; pwd)"
"$_dotfiles_src_dir/.dotfiles_run_prefixed.sh" install $@

