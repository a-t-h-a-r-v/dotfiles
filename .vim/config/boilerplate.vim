" Function to insert boilerplate into a new file
function! InsertBoilerplate()
    let filename = expand("%:p") " Get full file path of the new file
    let ext = expand("%:e") " Get file extension

    if !filereadable(filename)
        let template_path = expand("~/.vim/boilerplates/template." . ext)
        if filereadable(template_path)
            execute "0r " . template_path " Read and insert the template content at the top
            " Remove extra empty line at the end if exists
            execute "%s/\n\+\%$//e"
        endif
    endif
endfunction

" Auto-command to run on buffer creation
autocmd BufNewFile * call InsertBoilerplate()
