-- Function to insert the boilerplate into a new file
local function insert_boilerplate()
    local filename = vim.fn.expand("%:p") -- Get full file path of the new file
    local ext = vim.fn.expand("%:e") -- Get file extension

    if vim.fn.filereadable(filename) == 0 then -- Check if the file is empty or does not exist
        local template_path = "~/.config/nvim/boilerplates/template." .. ext
        if vim.fn.filereadable(vim.fn.expand(template_path)) == 1 then
            vim.cmd("0r " .. template_path) -- Read and insert the template content at the top
            -- Remove extra empty line at the end if exists
            vim.cmd([[%s/\n\+\%$//e]])
        end
    end
end

-- Set up autocmd to run the function on buffer creation or reading
vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*",
    callback = insert_boilerplate,
})
