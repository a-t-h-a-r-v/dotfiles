" Key mappings for coc.nvim
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>rn <Plug>(coc-rename)

" Use <Tab> for both indent and completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Key mappings for fzf
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :GFiles<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fh :Helptags<CR>
nnoremap <silent> <C-f> :Rg<space>

" Search word in browser
function! SearchWordInBrowser()
    let word = expand("<cword>")
    let url = "https://www.google.com/search?q=" . word
    call jobstart(["xdg-open", url], {'detach': v:true})
endfunction
nnoremap <leader>s :call SearchWordInBrowser()<CR>

" Toggle NERDTree
nnoremap <silent> <leader>e :NERDTreeToggle<CR>
