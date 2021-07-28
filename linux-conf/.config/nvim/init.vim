set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" -------------------------------------------------------------------
" file opens with the cursor at the same position where last left off 
autocmd BufReadPost *
\ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
\ |   exe "normal! g`\""
\ | endif

" ===== Vim-Plug Manager ===================================================================================================================={{{
call plug#begin('~/.vim/plugged')

" ----- EdiT --------------------------------------------------------------------------------------------------
Plug 'mg979/vim-visual-multi', {'branch': 'master'} " A mulit-cursor plugin
Plug 'tpope/vim-surround' " plugin for quoting/paranthesizing
Plug 'tpope/vim-commentary'

" ----- Searching -----
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'

" ----- Git ------------------------------------
Plug 'tpope/vim-fugitive' " a git plugin for vim
Plug 'airblade/vim-gitgutter'

" ----- Language Specific ------------------------------------------------------------------------------------
Plug 'sheerun/vim-polyglot' " A collection of language packs for Vim.

" ----- Terminal -----------
Plug 'voldikss/vim-floaterm'

" ----- LSP ------------------------------------------
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'
Plug 'folke/trouble.nvim'

" ----- UI ----------------------------------------------------------------------------------------------------
Plug 'folke/tokyonight.nvim'
Plug 'marko-cerovac/material.nvim'
Plug 'joshdick/onedark.vim'
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

call plug#end()"}}}

" =============================================================================
" ----- file/language specific compilation configuration ----------------------
" not exactly sure of the working of `autocmd FileType` for now (so be careful)
autocmd FileType cpp nnoremap <C-p> :FloatermNew makecp %<cr>
" actually mapped CTRL-/, linux recognizes CTRL-/ as CTRL-_
autocmd FileType cpp nnoremap <C-_> :FloatermNew tcase %<cr>
autocmd FileType python nnoremap <C-_> :FloatermNew python3 %<cr>

" -----------------------------------------------------------------------------
let g:tokyonight_style = 'night' " available: night, storm
let g:material_style = 'darker'
" colorscheme material 
colorscheme onedark 

set list lcs=tab:\|\ " show vertical guide lines between braces
set number relativenumber
set smartindent
set ignorecase " to search case-INsensitive
set smartcase " requires ignorcase
set autowrite
set nowrap
set tabstop=4
set shiftwidth=4
set showmatch
set cursorline " highlight the ROW on which the cursor is
set cursorcolumn " highlight the COLUMN on which the cursor is
set scrolloff=5 " minimal no. of screen lines to keep above & below the cursor
set foldmethod=marker " markers are used to specify folds

" ---------------------------------------------------------------------
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,InsertLeave,WinEnter * if &nu | set rnu   | endif
:  autocmd BufLeave,InsertEnter,WinLeave   * if &nu | set nornu | endif
:augroup END

" ------------------------------------------------------
" ctrl-a to select all
noremap <C-a> <Esc>ggvG$

" To ALWAYS use the clipboard for ALL operations 
" (instead of interacting with the '+' and/or '*' registers explicitly):
set clipboard+=unnamedplus

inoremap {<CR> {<CR>}<ESC>ko

" adding (C++) multi-line comment
vnoremap ? xi/**/<Esc>hP

" switch tabs in RHS-direction
nnoremap <Tab> :tabn<cr>
" swithch tabs in LHS-direction
nnoremap <S-Tab> :tabp<cr>

" ===== PLUGIN CONFIGURATIONS =============================================================================================================

" ----- nvim-lspconfig ---------------------------------------------------------{{{
lua << EOF
require'lspconfig'.clangd.setup{
	cmd = {"clangd-12"},
}

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

require'lspconfig'.vimls.setup{}
EOF

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end
EOF

lua << EOF
require('vim.lsp.protocol').CompletionItemKind = {
    '', -- Text
    '', -- Method
    '', -- Function
    '', -- Constructor
    '', -- Field
    '', -- Variable
    '', -- Class
    'ﰮ', -- Interface
    '', -- Module
    '', -- Property
    '', -- Unit
    '', -- Value
    '了', -- Enum
    '', -- Keyword
    '﬌', -- Snippet
    '', -- Color
    '', -- File
    '', -- Reference
    '', -- Folder
    '', -- EnumMember
    '', -- Constant
    '', -- Struct
    '', -- Event
    'ﬦ', -- Operator
    '', -- TypeParameter
}
EOF

lua << EOF
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, { 
		virtual_text = false,
		signs = true, 
		update_in_insert = false, 
		underline = true,
    }
)
EOF
"}}}

" ----- nvim-compe -------------------------------------------------------{{{
set completeopt=menuone,noselect

lua << EOF
-- Compe setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

inoremap <silent><expr> <cr>  compe#confirm('<cr>')
inoremap <silent><expr> <c-q> compe#close('<c-q>')
inoremap <silent><expr> <C-f> compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-b> compe#scroll({ 'delta': -4 })
"}}}

" ----- lspsaga ----------------------------{{{
lua << EOF
local saga = require 'lspsaga'

saga.init_lsp_saga {
	use_saga_diagnostic_sign = true,
	error_sign = '',
	warn_sign = '',
	hint_sign = ' ',
	infor_sign = '',
	dianostic_header_icon = '   ',
	code_action_icon = ' ',
	code_action_prompt = {
	  enable = true,
	  sign = true,
	  sign_priority = 20,
	  virtual_text = true,
	},
	finder_definition_icon = '  ',
	finder_reference_icon = '  ',
	definition_preview_icon = '  ',
	-- "single" "double" "round" "plus"
	border_style = "round", 
	rename_prompt_prefix = '➤',
}
EOF

" lsp provider to find the cursor word definition and reference
nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>

" code action
nnoremap <silent><leader>a <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>a :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>

" Hover
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

" SignatureHelp
nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>

" Rename
nnoremap <silent>gr <cmd>lua require('lspsaga.rename').rename()<CR>

" Preview Definition
nnoremap <silent> gd :Lspsaga preview_definition<CR>

" Show Diagnostic
nnoremap <silent><leader>d <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>

" only show diagnostic if cursor is over the area
nnoremap <silent><leader>c <cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>

" jump diagnostic
nnoremap <silent> [e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
nnoremap <silent> ]e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>

"}}}

" ----- trouble ----------{{{
lua << EOF
require("trouble").setup {
	position = "bottom", -- position of the list can be: bottom, top, left, right
    height = 10, -- height of the trouble list when position is top or bottom
    width = 50, -- width of the list when position is left or right
    icons = true, -- use devicons for filenames
    mode = "lsp_workspace_diagnostics", -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
    fold_open = "", -- icon used for open folds
    fold_closed = "", -- icon used for closed folds
    action_keys = { -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = {"<cr>"}, -- jump to the diagnostic or open / close folds
        open_split = { "<c-x>" }, -- open buffer in new split
        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
        open_tab = { "<c-t>" }, -- open buffer in new tab
        jump_close = {"o"}, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        close_folds = {"zM", "zm"}, -- close all folds
        open_folds = {"zR", "zr"}, -- open all folds
        toggle_fold = {"zA", "za"}, -- toggle fold of current file
        previous = "k", -- preview item
        next = "j" -- next item
    },
    indent_lines = true, -- add an indent guide below the fold icons
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    signs = {
        -- icons / text used for a diagnostic
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "﫠"
    },
    use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}
EOF

nnoremap <leader>t <cmd>TroubleToggle<cr>
"}}}

" ----- vim-floaterm --------------------
let g:floaterm_keymap_new = 'tt'
let g:floaterm_width = 0.8
let g:floaterm_height = 0.7

" ----- undotree -----------------
nnoremap <C-U> :UndotreeToggle<CR>

" ----- fzf -------------------------------------------------------------------------------------------------------------------------------{{{
command! -bang -complete=dir -nargs=?
			\ LS call fzf#run(fzf#wrap({'source': 'fd --hidden --exclude .git/ --exclude ".gitignore" --type f',
			\ 'dir': <q-args>,
			\ 'options': '--height=100% --margin=0 --multi --reverse --info=inline --prompt=$(pwd | sed "s/\/home\/rishi/~/")/ --preview "bat --style=numbers --color=always --line-range :500 {}"'},
			\ <bang>0))

" hide statusline for cleaner look
let g:fzf_layout = { 'down': '30%' }
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler"}}}

" ----- vim-commentary -----------------------------
autocmd FileType c,cpp setlocal commentstring=//\ %s

" ----- lualine -------------------------------------------------------------------------------------------------{{{
lua << EOF
require'lualine'.setup {
	options = {
    icons_enabled = true,
    theme = 'onedark',
    section_separators = {'', ''},
    component_separators = {'', ''},
    disabled_filetypes = {}
	},
	sections = {
	  lualine_a = {'mode'},
	  lualine_b = {'branch', 'diff'},
	  lualine_c = {{'filename', path = 1}},
	  lualine_x = {
	    {'diagnostics', sources = {"nvim_lsp"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '}},
	    'filetype',
	    'encoding'
	  },
	  lualine_y = {'progress'},
	  lualine_z = {'location'}
	},
	inactive_sections = {
	  lualine_a = {},
	  lualine_b = {},
	  lualine_c = {'filename'},
	  lualine_x = {'location'},
	  lualine_y = {},
	  lualine_z = {}
	},
	tabline = {},
	extensions = {'fugitive'}
}
EOF

"}}}

" ===== WSL yank support ========================================================================{{{
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif"}}}
