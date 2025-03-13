-- Set leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Basic Settings
vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Plugin Manager (packer)
require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    
    -- Autocompletion
    use {'neoclide/coc.nvim', branch = 'release'}
    
    -- Colorscheme
    use 'catppuccin/nvim'
    
    -- LSP (via coc.nvim extensions)
    vim.g.coc_global_extensions = {
        'coc-tsserver', 'coc-html', 'coc-css', 'coc-java', 'coc-pyright', 'coc-clangd', 'coc-sh'
    }
    
    -- Autopairs
    use {'windwp/nvim-autopairs', config = function()
        require('nvim-autopairs').setup {}
    end}
    
    -- Emmet
    use 'mattn/emmet-vim'
    
    -- Git Integration
    use 'tpope/vim-fugitive'
    
    -- Status Line
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    
    -- LaTeX Support
    use 'lervag/vimtex'
    
    -- Fuzzy File Search
    use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end}
    use 'junegunn/fzf.vim'
    
    -- File Explorer
    use 'preservim/nerdtree'
end)

-- Colorscheme Setup
vim.cmd [[colorscheme catppuccin-macchiato]]
vim.cmd [[hi Normal guibg=NONE ctermbg=NONE]]
vim.g.airline_theme = 'catppuccin'
vim.g.airline_powerline_fonts = 1

-- Key Mappings for coc.nvim
vim.api.nvim_set_keymap('n', '<leader>gd', '<Plug>(coc-definition)', {})
vim.api.nvim_set_keymap('n', '<leader>gr', '<Plug>(coc-references)', {})
vim.api.nvim_set_keymap('n', '<leader>rn', '<Plug>(coc-rename)', {})

-- Use <Tab> for both indent and completion
vim.api.nvim_set_keymap('i', '<Tab>', "pumvisible() ? '<C-n>' : '<Tab>'", {expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', "pumvisible() ? '<C-p>' : '<S-Tab>'", {expr = true})

-- Key Mappings for fzf
vim.api.nvim_set_keymap('n', '<leader>ff', ':Files<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fg', ':GFiles<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fb', ':Buffers<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fh', ':Helptags<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-f>', ':Rg<space>', {noremap = true})

-- Open NERDTree
vim.api.nvim_set_keymap('n', '<leader>e', ':NERDTreeToggle<CR>', {noremap = true})

-- Boilerplate Insertion
function InsertBoilerplate()
    local filename = vim.fn.expand("%:p")
    local basename = vim.fn.expand("%:t")
    local ext = vim.fn.expand("%:e")
    local template_path = os.getenv("HOME") .. "/.config/nvim/boilerplates/template." .. ext
    
    if basename == "CMakeLists.txt" then
        template_path = os.getenv("HOME") .. "/.config/vim/boilerplates/CMakeLists.txt"
    end
    
    if vim.fn.filereadable(filename) == 0 and vim.fn.filereadable(template_path) == 1 then
        vim.cmd("0r " .. template_path)
    end
end
vim.api.nvim_create_autocmd("BufNewFile", {pattern = "*", callback = InsertBoilerplate})

-- Search word in browser
function SearchWordInBrowser()
    local word = vim.fn.expand("<cword>")
    local url = "https://www.google.com/search?q=" .. word
    os.execute("xdg-open " .. url .. " &")
end
vim.api.nvim_set_keymap('n', '<Leader>s', ':lua SearchWordInBrowser()<CR>', {noremap = true})

-- Search selection in browser
function SearchSelectionInBrowser()
    local old_reg = vim.fn.getreg('"')
    vim.cmd('normal! gvy')
    local selection = vim.fn.getreg('"')
    local url = "https://www.google.com/search?q=" .. vim.fn.escape(selection, " ")
    os.execute("xdg-open " .. url .. " &")
    vim.fn.setreg('"', old_reg)
end
vim.api.nvim_set_keymap('v', '<Leader>gs', ':lua SearchSelectionInBrowser()<CR>', {noremap = true})

-- VimTeX Configuration
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_compiler_method = 'latexmk'
vim.g.vimtex_compiler_latexmk = {
    build_dir = 'build',
    callback = 1,
    continuous = 1,
    executable = 'latexmk',
    options = {
        '-pdf',
        '-interaction=nonstopmode',
        '-synctex=1'
    }
}
