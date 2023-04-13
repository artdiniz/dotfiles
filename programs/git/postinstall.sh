_SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"

_git_user_name=""
_git_user_email=""

_prompt_and_confirm "Your name:" _git_user_name
_prompt_and_confirm "Your email (prefer github's noreply email):" _git_user_email

_private_env_file_path="$_SCRIPT_DIR/$_DOTFILES_PRIVATE_ENV_FILE"
_create_and_write_file "$_private_env_file_path" <<-GIT_PRIVATE_ENV_FILE

	export GIT_AUTHOR_NAME='$_git_user_name'
	export GIT_AUTHOR_EMAIL='$_git_user_email'

	export GIT_COMMITTER_NAME='$_git_user_name'
	export GIT_COMMITTER_EMAIL='$_git_user_email'

GIT_PRIVATE_ENV_FILE

printf "\n%s \n\n" "Created: $(_parse_to_path_with_tilde "$_private_env_file_path")"
