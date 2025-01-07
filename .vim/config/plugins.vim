call plug#begin('~/.vim/plugged')

" Plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'             " Gruvbox colorscheme
Plug 'windwp/nvim-autopairs'       " Autopairs for brackets and quotes
Plug 'mattn/emmet-vim'             " Emmet for HTML and CSS
Plug 'tpope/vim-fugitive'          " Git integration
Plug 'vim-airline/vim-airline'     " Status line
Plug 'vim-airline/vim-airline-themes'
Plug 'lervag/vimtex'               " LaTeX support
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy finder
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'          " File tree explorer

call plug#end()

" Colorscheme
set background=dark
colorscheme gruvbox
highlight Normal ctermbg=NONE guibg=NONE " Transparent background

" coc.nvim extensions
let g:coc_global_extensions = [
\ 'coc-tsserver', 'coc-html', 'coc-css',
\ 'coc-java', 'coc-pyright', 'coc-clangd', 'coc-sh'
\]

" vimtex configuration
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_compiler_latexmk = {
\ 'build_dir': 'build',
\ 'callback': 1,
\ 'continuous': 1,
\ 'executable': 'latexmk',
\ 'options': ['-pdf', '-interaction=nonstopmode', '-synctex=1']
\}
