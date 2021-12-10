-- change comment style for cpp file
vim.api.nvim_buf_set_option("0", "commentstring", "// %s")

local map = require("utils").map

-- create mappings for compiling & running C++ files
map("n", "<C-p>", ":TermExec cmd='makecp %'<CR>", {})
map("n", "<C-_>", ":TermExec cmd='tcase %'<CR>", {}) -- actually mapped CTRL-/, my linux machine recognizes CTRL-/ as CTRL-_
