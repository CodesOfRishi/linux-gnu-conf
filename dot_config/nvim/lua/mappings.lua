local map = require("utils").map

-- CTRL-a to select all
map("n", "<C-a>", "<Esc>ggVG$", {})

-- automatically add matching curly brackets
map("i", "{<CR>", "{<CR>}<Esc>ko", {})

-- C++ multi-line comment
map("v", "?", "xi/**/<Esc>hP", {})

-- switch tabs in RHS-direction
map("n", "<Tab>", "<Cmd>tabn<CR>", {})

-- switch tabs in LHS-direction
map("n", "<S-Tab>", "<Cmd>tabp<CR>", {})

-- source current file
map("n", "<C-s>", "<Cmd>source %<CR>", {})

-- CTRL-j & CTRL-k to move selected lines down & up respectively
map("v", "<C-j>", ":m '>+1<CR>gv=gv", {})
map("v", "<C-k>", ":m '<-2<CR>gv=gv", {})

-- nvim-lspconfig{{{
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", {})
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", {})
map("n", "<leader>dd", "<cmd>lua vim.diagnostic.open_float()<CR>", {})
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", {})
map("n", "gd", "<cmd>lua vim.lsp.buf.declaration()<CR>", {})
map("n", "gD", "<cmd>lua vim.lsp.buf.definition()<CR>", {})
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", {})
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", {})
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", {})
map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {})--}}}

-- Trouble plugin{{{
map("n", "<leader>da", "<Cmd>TroubleToggle document_diagnostics<CR>", {})--}}}

-- Nvim-Tree plugin{{{
map("n", "te", "<Cmd>NvimTreeToggle<CR>", {})
map("n", "tr", "<Cmd>NvimTreeRefresh<CR>", {})
map("n", "tf", "<Cmd>NvimTreeFindFile<CR>", {})
--}}}

-- Undotree plugin{{{
map("n", "<leader>ut", "<Cmd>UndotreeToggle<CR>", {})--}}}

-- telescope{{{
map("n", "<leader>ff", "<Cmd>Telescope find_files hidden=true<CR>", {})
map("n", "<leader>fg", "<Cmd>Telescope live_grep<CR>", {})
map("n", "<leader>fG", "<Cmd>Telescope live_grep grep_open_files=true<CR>", {})
map("n", "<leader>fc", "<Cmd>Telescope commands<CR>", {})
map("n", "<leader>fb", "<Cmd>Telescope buffers<CR>", {})
map("n", "<leader>ls", "<Cmd>Telescope file_browser hidden=true<CR>", {})

-- telescope lsp
map("n", "<leader>a", "<Cmd>Telescope lsp_code_actions theme=get_cursor<CR>", {})
map("n", "<leader>dw", "<Cmd>Telescope diagnostics<CR>", {})

-- telescope git
map("n", "<C-g><C-h>", "<Cmd>Telescope git_commits<CR>", {})
map("n", "<C-g><C-f>", "<Cmd>Telescope git_status<CR>", {})
map("n", "<C-g><C-b>", "<Cmd>Telescope git_branches<CR>", {})
--}}}
