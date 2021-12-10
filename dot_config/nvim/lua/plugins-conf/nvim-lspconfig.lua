-- language server setup{{{
require'lspconfig'.clangd.setup{
	cmd = {"clangd-12"},
}

require'lspconfig'.bashls.setup{}

require'lspconfig'.pyright.setup{
	settings = {
		pyright = {
			disableLanguageServices = false,
			disableOrganizeImports = false
		},
		python = {
			analysis = {
				autoImportCompletions = true,
				autoSearchPaths = true
			},
			pythonPath = "python3"
		}
	}
}

require'lspconfig'.vimls.setup{}--}}}

-- lsp handlers{{{
local border_style = {
	{ "╭", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╮", "FloatBorder" },
	{ "│", "FloatBorder" },
	{ "╯", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╰", "FloatBorder" },
	{ "│", "FloatBorder" },
}

local pop_opts = { border = border_style }
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, pop_opts)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, pop_opts)--}}}

--disable virtual_text
vim.diagnostic.config({virtual_text = false})

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	--Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

end

