mkdir -p "$HOME/.dotfiles/bin"

rm -rf "$HOME/.dotfiles/src"
ln -s "$_DOTFILES_DIR" "$HOME/.dotfiles/src"

# TODO backup bash and zsh
# TODO add backup bash and xsh files execution to shell env
$_DOTFILES_DIR/.src/files_link.sh .dotfiles
$_DOTFILES_DIR/.src/files_link.sh bash
$_DOTFILES_DIR/.src/files_link.sh zsh
