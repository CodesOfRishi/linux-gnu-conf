-- change comment style for cpp file
vim.api.nvim_buf_set_option("0", "commentstring", "// %s")

local map = require("utils").map

-- create mappings for compiling & running C++ files
map("n", "<C-p>", ":FloatermNew makecp %<CR>", {})
map("n", "<C-_>", ":FloatermNew tcase %<CR>", {}) -- actually mapped CTRL-/, linux recognizes CTRL-/ as CTRL-_
