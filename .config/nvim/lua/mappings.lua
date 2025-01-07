-- Key mappings for coc.nvim
vim.api.nvim_set_keymap('n', '<leader>gd', '<Plug>(coc-definition)', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>gr', '<Plug>(coc-references)', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>rn', '<Plug>(coc-rename)', {silent = true})

-- Use <Tab> for both indent and completion
vim.api.nvim_set_keymap("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', { noremap = true, expr = true, silent = true })

-- Key mappings for fzf
vim.api.nvim_set_keymap('n', '<leader>ff', ':Files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fg', ':GFiles<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fb', ':Buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fh', ':Helptags<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-f>', ':Rg<space>', { noremap = true, silent = true })

function SearchWordInBrowser()
    local word = vim.fn.expand("<cword>")
    local url = "https://www.google.com/search?q=" .. word
    vim.fn.jobstart({"xdg-open", url}, {detach = true})
end

vim.keymap.set("n", "<Leader>s", SearchWordInBrowser, { desc = "Search word in browser" })
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

