DOTFILES_DIR=$(pwd)
ln -sf "$DOTFILES_DIR/.vimrc" ~/.vimrc
ln -sf "$DOTFILES_DIR/.vim" ~/.vim
ln -sf "$DOTFILES_DIR/.config/nvim" ~/.config/nvim
ln -sf "$DOTFILES_DIR/.config/hyprland" ~/.config/hyprland
echo "Dotfiles setup complete!"
