#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"
VIM_BOILERPLATES="$HOME/.vim/boilerplates"
NVIM_BOILERPLATES="$HOME/.config/nvim/boilerplates"
NVIM_INIT="$HOME/.config/nvim/init.lua"
VIMRC="$HOME/.vimrc"

echo "Warning: This will remove your existing .vim, .vimrc, and .config/nvim directories/files."
read -p "Do you want to proceed? (y/N): " choice
case "$choice" in 
  y|Y )
    echo "Removing existing configurations..."
    rm -rf "$HOME/.vim" "$HOME/.vimrc" "$HOME/.config/nvim"
    ;;
  * )
    echo "Aborted."
    exit 1
    ;;
esac

mkdir -p "$HOME/.vim"
mkdir -p "$HOME/.config/nvim"

ln -sfn "$DOTFILES_DIR/.vim/boilerplates" "$VIM_BOILERPLATES"
ln -sfn "$DOTFILES_DIR/.vim/boilerplates" "$NVIM_BOILERPLATES"

ln -sf "$DOTFILES_DIR/.config/nvim/init.lua" "$NVIM_INIT"
ln -sf "$DOTFILES_DIR/.vimrc" "$VIMRC"

echo "Installing vim-plug..."
curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim || {
    echo "Failed to download vim-plug."
    exit 1
}

echo "Installing Packer..."
PACKER_DIR="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"

if [ -d "$PACKER_DIR" ] && [ "$(ls -A "$PACKER_DIR")" ]; then
    echo "Packer is already installed or the directory is not empty. Skipping..."
else
    git clone --depth 1 https://github.com/wbthomason/packer.nvim "$PACKER_DIR" || {
        echo "Failed to clone Packer."
        exit 1
    }
    echo "Packer installed successfully."
fi

echo "Setup Complete."
