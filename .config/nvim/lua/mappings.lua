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

-- lspsaga plugin{{{
-- lsp provider to find the cursor word definition and reference
-- NOTE: mapped to Telescope's lsp picker
map("n", "gh", "<Cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", {})

-- code action
-- NOTE: mapped to Telescope's lsp picker
--[[ map("n", "<leader>a", "<Cmd>lua require('lspsaga.codeaction').code_action()<CR>", {})
map("v", "<leader>a", "<Cmd><C-u>lua require('lspsaga.codeaction').range_code_action()<CR>", {}) ]]

-- hover
map("n", "K", "<Cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", {})
map("n", "<C-f>", "<Cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", {})
map("n", "<C-b>", "<Cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", {})

-- signature help
map("n", "gs", "<Cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", {})

-- renaming
map("n", "<leader>rn", "<Cmd>lua require('lspsaga.rename').rename()<CR>", {})

-- preview definition
-- NOTE: mapped to Telescope's lsp picker
-- map("n", "gd", "<Cmd>lua require'lspsaga.provider'.preview_definition()<CR>", {})

-- show diagnostics
map("n", "<leader>dd", "<Cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", {})

-- only show diagnostics if cursor is over the area
map("n", "<leader>dc", "<Cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>", {})

-- jump diagnostics
map("n", "[e", "<Cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", {})
map("n", "]e", "<Cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", {});
--}}}

-- Trouble plugin{{{
map("n", "<leader>da", "<Cmd>TroubleToggle lsp_document_diagnostics<CR>", {})--}}}

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
map("n", "gd", "<Cmd>Telescope lsp_definitions theme=get_cursor<CR>", {})
map("n", "<leader>a", "<Cmd>Telescope lsp_code_actions theme=get_cursor<CR>", {})
map("n", "<leader>dw", "<Cmd>Telescope lsp_workspace_diagnostics<CR>", {})

-- telescope git
map("n", "<C-g><C-h>", "<Cmd>Telescope git_commits<CR>", {})
map("n", "<C-g><C-f>", "<Cmd>Telescope git_status<CR>", {})
map("n", "<C-g><C-b>", "<Cmd>Telescope git_branches<CR>", {})
--}}}
