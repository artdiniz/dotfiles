cd() {
  builtin cd "$@"
  usegitconfiguser
}