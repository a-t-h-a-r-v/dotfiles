DOTFILES_DIR=$(pwd)
ln -sf "$DOTFILES_DIR/.vimrc" ~/.vimrc
ln -sf "$DOTFILES_DIR/.vim" ~/.vim
ln -sf "$DOTFILES_DIR/.config/nvim" ~/.config/nvim
ln -sf "$DOTFILES_DIR/.config/hyprland" ~/.config/hyprland
ln -sf "$DOTFILES_DIR/.config/waybar" ~/.config/waybar
ln -sf "$DOTFILES_DIR/.config/sway" ~/.config/sway
echo "Dotfiles setup complete!"
