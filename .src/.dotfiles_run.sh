#!/usr/bin/env bash
_dotfiles_src_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
. "$_dotfiles_src_dir/.dotfiles_env_source.sh"

"$1"
