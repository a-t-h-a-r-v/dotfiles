" .vimrc Configuration

" Set leader keys
let mapleader = " "
let maplocalleader = " "

" Basic Settings
set number
set relativenumber
set termguicolors
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Plugin Manager (vim-plug)
call plug#begin('~/.vim/plugged')

" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Colorscheme
Plug 'catppuccin/vim'

" LSP (via coc.nvim extensions)
let g:coc_global_extensions = [
    \ 'coc-tsserver', 'coc-html', 'coc-css', 'coc-java', 'coc-pyright', 'coc-clangd', 'coc-sh'
    \ ]

" Autopairs
Plug 'jiangmiao/auto-pairs'

" Emmet
Plug 'mattn/emmet-vim'

" Git Integration
Plug 'tpope/vim-fugitive'

" Status Line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" LaTeX Support
Plug 'lervag/vimtex'

" Fuzzy File Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" File Explorer
Plug 'preservim/nerdtree'

call plug#end()

" Colorscheme Setup
colorscheme catppuccin_macchiato
hi Normal guibg=NONE ctermbg=NONE

" Key Mappings for coc.nvim
nnoremap <leader>gd <Plug>(coc-definition)
nnoremap <leader>gr <Plug>(coc-references)
nnoremap <leader>rn <Plug>(coc-rename)

" Use <Tab> for both indent and completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Key Mappings for fzf
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :GFiles<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fh :Helptags<CR>
nnoremap <C-f> :Rg<space>

" Open NERDTree
nnoremap <leader>e :NERDTreeToggle<CR>

" Boilerplate Insertion
function! InsertBoilerplate()
    let filename = expand("%:p")
    let basename = expand("%:t")
    let ext = expand("%:e")
    let template_path = "$HOME/.vim/boilerplates/template." . ext

    if basename == "CMakeLists.txt"
        let template_path = "$HOME/.vim/boilerplates/CMakeLists.txt"
    endif

    if !filereadable(filename) && filereadable(expand(template_path))
        execute "0r " . template_path
    endif
endfunction

autocmd BufNewFile * call InsertBoilerplate()

" Search word in browser
function! SearchWordInBrowser()
    let word = expand("<cword>")
    let url = "https://www.google.com/search?q=" . word
    call system("xdg-open " . url . " &")
endfunction

nnoremap <Leader>s :call SearchWordInBrowser()<CR>

" Search selection in browser
function! SearchSelectionInBrowser()
    let old_reg = @"
    normal! gvy
    let selection = @"
    let url = "https://www.google.com/search?q=" . escape(selection, " ")
    call system("xdg-open " . url . " &")
    let @" = old_reg
endfunction

vnoremap <Leader>gs :call SearchSelectionInBrowser()<CR>

" VimTeX Configuration
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_compiler_latexmk = {
    \ 'build_dir': 'build',
    \ 'callback': 1,
    \ 'continuous': 1,
    \ 'executable': 'latexmk',
    \ 'options': [
    \     '-pdf',
    \     '-interaction=nonstopmode',
    \     '-synctex=1'
    \ ]
    \ }
