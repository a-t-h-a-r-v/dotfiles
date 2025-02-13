-- Function to insert the boilerplate into a new file
local function insert_boilerplate()
    local filename = vim.fn.expand("%:p") -- Get full file path
    local basename = vim.fn.expand("%:t") -- Get just the filename
    local ext = vim.fn.expand("%:e") -- Get file extension

    local template_path

    -- Use a special template for CMakeLists.txt
    if basename == "CMakeLists.txt" then
        template_path = "~/.config/nvim/boilerplates/CMakeLists.txt"
    else
        template_path = "~/.config/nvim/boilerplates/template." .. ext
    end

    -- Check if file exists and is empty before inserting the template
    if vim.fn.filereadable(filename) == 0 and vim.fn.filereadable(vim.fn.expand(template_path)) == 1 then
        vim.cmd("0r " .. template_path) -- Read and insert the template content at the top
        vim.cmd([[%s/\n\+\%$//e]]) -- Remove extra empty line at the end if exists
    end
end

-- Set up autocmd to run the function on buffer creation
vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*",
    callback = insert_boilerplate,
})
