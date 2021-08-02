-- map commands for compiling and/or running programming language scripts
-- not exactly sure of the working of `autocmd FileType` for now (so be careful) !!!
vim.cmd([[
	autocmd FileType cpp nnoremap <C-p> :FloatermNew makecp %<cr>

	" actually mapped CTRL-/, linux recognizes CTRL-/ as CTRL-_
	autocmd FileType cpp nnoremap <C-_> :FloatermNew tcase %<cr>
	autocmd FileType python nnoremap <C-_> :FloatermNew ./%<cr>
	autocmd FileType lua nnoremap <C-_> :FloatermNew ./%<cr>
]])

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
