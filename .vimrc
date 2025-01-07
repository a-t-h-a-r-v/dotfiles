" Source individual configuration files
source ~/.vim/config/settings.vim
source ~/.vim/config/plugins.vim
source ~/.vim/config/mappings.vim
source ~/.vim/config/boilerplate.vim

" General settings
set runtimepath+=~/.vim

" Initialize plugins using Vim-Plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
set clipboard=unnamedplus
