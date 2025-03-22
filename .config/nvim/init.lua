-- Ensure packer is loaded
vim.cmd [[packadd packer.nvim]]

-- Set tab to 2 spaces
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true
vim.o.termguicolors = true

-- Show line numbers and relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Set space as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set up packer
require('packer').startup(function(use)
  -- Packer manages itself
  use 'wbthomason/packer.nvim'

  -- LSP support
  use 'neovim/nvim-lspconfig'

  -- Autocompletion plugins
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'

  -- Auto-pairing brackets and quotes
  use 'windwp/nvim-autopairs'
  use 'tpope/vim-surround'

  -- Recent files plugin
  use 'mhinz/vim-startify'

  -- Catppuccin theme
  use { 'catppuccin/nvim', as = 'catppuccin' }

  -- Add lualine status bar
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  use 'tpope/vim-fugitive'

  -- Fuzzy File Search
  use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end}
  use 'junegunn/fzf.vim'

  -- File Explorer
  use 'preservim/nerdtree'

  -- Automatically sync plugins after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Configure LSP for C/C++ with clangd
local lspconfig = require('lspconfig')

lspconfig.clangd.setup({
  cmd = { 'clangd' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
  root_dir = lspconfig.util.root_pattern('.clangd', 'compile_commands.json', 'compile_flags.txt', '.git'),
  settings = {
    clangd = {
      fallbackFlags = { '-std=c++20' },
      completion = {
        detailedLabel = true
      } 
    },
  },
  on_attach = function(client, bufnr)
    local opts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

    -- Automatically show parameter hints
    vim.cmd [[autocmd CursorHoldI * lua vim.lsp.buf.signature_help()]]
  end
})

-- Setup nvim-cmp for autocompletion
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

-- Setup nvim-autopairs
require('nvim-autopairs').setup({
  check_ts = true,
})

-- Set Catppuccin theme (Macchiato variant)
require('catppuccin').setup({
  flavour = 'macchiato',
  integrations = {
    nvimtree = true,
    treesitter = true,
    cmp = true,
    lsp_trouble = true,
    telescope = true,
  },
})
vim.cmd.colorscheme 'catppuccin'

-- Keybinding for easier LSP info access
vim.api.nvim_set_keymap('n', '<leader>li', ':LspInfo<CR>', { noremap = true, silent = true })

-- Load LuaSnip snippets for boilerplates
require('luasnip.loaders.from_lua').load({ paths = '~/.config/nvim/lua/snippets/' })

-- Auto-insert boilerplate templates for new files
local function insert_boilerplate()
  local filename = vim.fn.expand('%:t')
  local extension = vim.fn.expand('%:e')
  local template_path = string.format('~/.config/nvim/boilerplates/template.%s', extension)

  if vim.fn.filereadable(vim.fn.expand(template_path)) == 1 then
    local content = vim.fn.readfile(vim.fn.expand(template_path))
    vim.api.nvim_buf_set_lines(0, 0, -1, false, content)
  end
end

vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = '*.*',
  callback = insert_boilerplate
})

-- Compile C/C++ files with Make or fallback to gcc/clang
vim.api.nvim_set_keymap('n', '<leader>cc', 
":w<CR>:lua if vim.fn.filereadable('Makefile') == 1 then vim.cmd('!make') else vim.cmd('!gcc % -o %< && ./%<') end<CR>", 
{ noremap = true, silent = true })

-- Setup lualine with Catppuccin theme
require('lualine').setup({
  options = {
    theme = 'catppuccin',
    icons_enabled = true,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  extensions = {'quickfix', 'fugitive'}
})

-- Key Mappings for fzf
vim.api.nvim_set_keymap('n', '<leader>ff', ':Files<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fg', ':GFiles<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fb', ':Buffers<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fh', ':Helptags<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-f>', ':Rg<space>', {noremap = true})

-- Open NERDTree
vim.api.nvim_set_keymap('n', '<leader>e', ':NERDTreeToggle<CR>', {noremap = true})
