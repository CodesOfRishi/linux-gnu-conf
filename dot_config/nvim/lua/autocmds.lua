-- file opens with the cursor at the same position where last left off 
vim.cmd([[
	autocmd BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' | exe "normal! g`\"" | endif
]])

vim.cmd([[
	augroup numbertoggle
		autocmd!
		autocmd BufEnter,InsertLeave,WinEnter * if &nu | set rnu   | endif
		autocmd BufLeave,InsertEnter,WinLeave   * if &nu | set nornu | endif
	augroup END
]])

-- for highlighting a selection on yank
vim.cmd([[
	au TextYankPost * silent! lua vim.highlight.on_yank { timeout = 450 }
]])

vim.cmd([[
	sign define DiagnosticSignError text= texthl=DiagnosticSignError
	sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn
	sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo
	sign define DiagnosticSignHint text= texthl=DiagnosticSignHint
]])
