-- change comment style for cpp file
vim.api.nvim_buf_set_option("0", "commentstring", "// %s")

-- template for mapping
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- create mappings for compiling & running C++ files
map("n", "<C-p>", ":FloatermNew makecp %<CR>", {})
map("n", "<C-_>", ":FloatermNew tcase %<CR>", {}) -- actually mapped CTRL-/, linux recognizes CTRL-/ as CTRL-_
