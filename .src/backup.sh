#!/usr/bin/env bash
_dotfiles_src_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
"$_dotfiles_src_dir/.dotfiles_run_prefixed.sh" backup $@

#TODO backup outputs from files_copy.sh, files_link.sh and files_modify.sh
