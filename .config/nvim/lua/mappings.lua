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
function SearchSelectionInBrowser()
    -- Get the start and end positions of the visual selection
    local _, start_row, start_col, _ = unpack(vim.fn.getpos("'<"))
    local _, end_row, end_col, _ = unpack(vim.fn.getpos("'>"))

    -- Adjust for 0-based indexing
    start_row = start_row - 1
    end_row = end_row - 1

    -- Fetch the selected lines
    local lines = vim.api.nvim_buf_get_lines(0, start_row, end_row + 1, false)

    -- Handle column adjustments for multi-line selection
    lines[1] = string.sub(lines[1], start_col + 1)
    if #lines > 1 then
        lines[#lines] = string.sub(lines[#lines], 1, end_col)
    else
        lines[1] = string.sub(lines[1], 1, end_col - start_col)
    end

    -- Concatenate the selected text
    local selected_text = table.concat(lines, " ")

    -- Construct the search URL
    local url = "https://www.google.com/search?q=" .. vim.fn.escape(selected_text, " ")

    -- Open the URL in the default browser
    vim.fn.jobstart({"xdg-open", url}, {detach = true})
end

-- Map the function to a keybinding in visual mode
vim.api.nvim_set_keymap("v", "<Leader>gs", ":lua SearchSelectionInBrowser()<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<Leader>s", SearchWordInBrowser, { desc = "Search word in browser" })
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

