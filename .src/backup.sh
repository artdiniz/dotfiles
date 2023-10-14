#!/usr/bin/env bash
_dotfiles_src_dir="$(cd "$(dirname "$BASH_SOURCE")"; pwd)"
"$_dotfiles_src_dir/.dotfiles_run_prefixed.sh" backup $@

#TODO backup outputs from files_copy.sh and files_link.sh and files_modify.sh
