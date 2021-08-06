-- template for mapping
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- create mappings for running python scripts
-- make sure script contains the shebang specifying the interpreter &,
-- the scpript has the executable permission
map("n", "<C-_>", ":FloatermNew ./%<CR>", {})
