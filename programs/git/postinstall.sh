#!/usr/bin/env bash 
set -u

# shellcheck source=../../dotfiles/lib/globals.sh
. "$HOME"/dotfiles/dotfiles/lib/globals.sh

# shellcheck source=../../dotfiles/lib/_prompt_and_confirm.sh
. "$HOME"/dotfiles/dotfiles/lib/_prompt_and_confirm.sh

_git_user_name=""
_git_user_email=""

_prompt_and_confirm "Your name:" _git_user_name
_prompt_and_confirm "Your email:" _git_user_email

cat > "$DOTFILES_PRIVATE_ENV_FILE" <<GITCONFIG

export GIT_AUTHOR_NAME='$_git_user_name'
export GIT_AUTHOR_EMAIL='$_git_user_email'

export GIT_COMMITTER_NAME='$_git_user_name'
export GIT_COMMITTER_EMAIL='$_git_user_email'

GITCONFIG
