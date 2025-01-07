-- Install Packer if not already installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Plugins
require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- coc.nvim for autocompletion
    use {'neoclide/coc.nvim', branch = 'release'}

    -- Colorscheme that supports transparency
    use 'morhetz/gruvbox'

    -- LSP Config
    use 'neovim/nvim-lspconfig'

    -- Autopairs
    use 'windwp/nvim-autopairs'

    -- Emmet
    use 'mattn/emmet-vim'

    --vim-fugitive
    use 'tpope/vim-fugitive'

    --vim-airline
    use 'vim-airline/vim-airline'

    --vim-airline-themes
    use 'vim-airline/vim-airline-themes'

    --vimtex
    use 'lervag/vimtex'

    --fuzzy file search
    use { 'junegunn/fzf', run = 'fzf#install()' }
    use { 'junegunn/fzf.vim' }
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        config = function()
            require("nvim-tree").setup()
        end
    }
    if packer_bootstrap then
        require('packer').sync()
    end
end)

-- Colorscheme
vim.cmd [[colorscheme gruvbox]]
vim.cmd [[hi Normal guibg=NONE ctermbg=NONE]]  -- Make background transparent

-- LSP Setup
local lspconfig = require('lspconfig')

local servers = { 'clangd', 'jdtls', 'ts_ls', 'html', 'cssls', 'bashls', 'pyright' }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {}
end

-- coc.nvim configuration
vim.g.coc_global_extensions = {
    'coc-tsserver', 'coc-html', 'coc-css', 'coc-java', 'coc-pyright', 'coc-clangd', 'coc-sh'
}

-- nvim-autopairs setup
require('nvim-autopairs').setup{}

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
        '-synctex=1',
    },
}
