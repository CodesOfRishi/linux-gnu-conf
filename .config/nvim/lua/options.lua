vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.ignorecase = true -- to search case-INsensitive
vim.opt.smartcase = true -- requires ignorcase
vim.opt.autowrite = true
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.showmatch = true
vim.opt.cursorline = true -- highlight the ROW on which the cursor is
vim.opt.cursorcolumn = true -- highlight the COLUMN on which the cursor is
vim.opt.scrolloff = 5 -- minimal no. of screen lines to keep above & below the cursor
vim.opt.foldmethod = "marker" -- markers are used to specify folds
vim.opt.list = true
vim.opt.listchars = { space = ' ', tab = '⋮ ' }

-- To ALWAYS use the clipboard for ALL operations 
-- (instead of interacting with the '+' and/or '*' registers explicitly):
vim.opt.clipboard:append("unnamedplus")
