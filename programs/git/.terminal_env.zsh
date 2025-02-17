usegitconfiguser() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then 
    if git config --local user.name &>/dev/null; then
      export GIT_AUTHOR_NAME="$(git config --local user.name)"
      export GIT_COMMITTER_NAME="$(git config --local user.name)"
    else
      export GIT_AUTHOR_NAME="$ROOT_GIT_AUTHOR_NAME"
      export GIT_COMMITTER_NAME="$ROOT_GIT_COMMITTER_NAME"
    fi
    if git config --local user.email &>/dev/null; then
      export GIT_AUTHOR_EMAIL="$(git config --local user.email)"
      export GIT_COMMITTER_EMAIL="$(git config --local user.email)"
    else
      export GIT_AUTHOR_EMAIL="$ROOT_GIT_AUTHOR_EMAIL"
      export GIT_COMMITTER_EMAIL="$ROOT_GIT_COMMITTER_EMAIL"
    fi
  else
    :
  fi
}

chpwd_functions+=(usegitconfiguser)

usegitconfiguser
