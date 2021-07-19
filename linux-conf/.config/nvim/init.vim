set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" ===== Vim-Plug Manager ====================================================================================================================
call plug#begin('~/.vim/plugged')

" ----- EDIT --------------------------------------------------------------------------------------------------
Plug 'mg979/vim-visual-multi', {'branch': 'master'} " A mulit-cursor plugin
Plug 'tpope/vim-surround' " plugin for quoting/paranthesizing
Plug 'tpope/vim-commentary'

" ----- Searching -----
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
" ---------------------

" ----- Git ------------------------------------
Plug 'tpope/vim-fugitive' " a git plugin for vim
Plug 'airblade/vim-gitgutter'
" ----------------------------------------------

" ----- Language Specific ------------------------------------------------------------------------------------
Plug 'sheerun/vim-polyglot' " A collection of language packs for Vim.
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" ----- LSP ------------------------------------------
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'

" ----- UI ----------------------------------------------------------------------------------------------------
Plug 'folke/tokyonight.nvim'
Plug 'vim-airline/vim-airline' " Lean & mean status/tabline for vim
Plug 'vim-airline/vim-airline-themes' " Official themes for vim-airline (vim-airline must be installed)
Plug 'ryanoasis/vim-devicons' " add icons (always load devicons as the very last plugin)

call plug#end()
" ===========================================================================================================================================

" =============================================================================
" ----- file/language specific compilation configuration ----------------------
" not exactly sure of the working of `autocmd FileType` for now (so be careful)
autocmd FileType cpp nnoremap <C-B> :!makecp %<cr>
" actually mapped CTRL-/, linux recognizes CTRL-/ as CTRL-_
autocmd FileType cpp nnoremap <C-_> :!tcase %<cr>
autocmd FileType python nnoremap <C-B> :!python3 %<cr>
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
let g:tokyonight_style = 'night' " available: night, storm
colorscheme tokyonight 

:set list lcs=tab:\|\ " show vertical guide lines between braces
:set number relativenumber
:set smartindent
:set ignorecase " to search case-INsensitive
:set smartcase " requires ignorcase
:set autowrite
:set nowrap
:set tabstop=4
:set shiftwidth=4
:set showmatch
:set cursorline " highlight the ROW on which the cursor is
:set cursorcolumn " highlight the COLUMN on which the cursor is
:set scrolloff=5 " minimal no. of screen lines to keep above & below the cursor
" -----------------------------------------------------------------------------

" ---------------------------------------------------------------------
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,InsertLeave,WinEnter * if &nu | set rnu   | endif
:  autocmd BufLeave,InsertEnter,WinLeave   * if &nu | set nornu | endif
:augroup END
" ---------------------------------------------------------------------

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
" ------------------------------------------------------
" =============================================================================

" ===== PLUGIN CONFIGURATIONS =============================================================================================================

" ----- nvim-lspconfig ---------------------------------------------------------
lua << EOF
require'lspconfig'.clangd.setup{}
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

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "rust_analyzer", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF
" ------------------------------------------------------------------------------

" ----- nvim-compe -------------------------------------------------------
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
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
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

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
let g:compe.source.emoji = v:true
" ------------------------------------------------------------------------

" ----- lspsaga ----------------------------
lua << EOF
local saga = require 'lspsaga'

saga.init_lsp_saga {
	use_saga_diagnostic_sign = true,
	error_sign = '',
	warn_sign = '',
	hint_sign = ' ',
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
nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>

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
" ------------------------------------------

" ----- nvim-treesitter -------------------------------------------------------------------------------------------
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "java", "python", "toml" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF
" -----------------------------------------------------------------------------------------------------------------

" ----- fzf -------------------------------------------------------------------------------------------------------------------------------
command! -bang -complete=dir -nargs=?
			\ LS call fzf#run(fzf#wrap({'source': 'fd --hidden --exclude .git/ --exclude ".gitignore" --type f',
			\ 'dir': <q-args>,
			\ 'options': '--height=100% --margin=0 --multi --reverse --info=inline --prompt=$(pwd | sed "s/\/home\/rishi/~/")/ --preview "bat --style=numbers --color=always --line-range :500 {}"'},
			\ <bang>0))

" hide statusline for cleaner look
let g:fzf_layout = { 'down': '30%' }
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
" -----------------------------------------------------------------------------------------------------------------------------------------

" ----- material theme --------------
let g:material_terminal_italics = 1
let g:material_theme_style = 'darker'
" -----------------------------------

" ----- vim-commentary -----------------------------
autocmd FileType c,cpp setlocal commentstring=//\ %s
" --------------------------------------------------

" ---- airline ---------------------------------------------------------------------
" airline-customization (for this customization you need to install powerline-fonts)
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
" let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = ':'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'
" ----------------------------------------------------------------------------------

" -----------------------------------------------------------------------------------------------------------
" deus theme (check out available airline themes:https://github.com/vim-airline/vim-airline/wiki/Screenshots)
" vim-airline themes is needed for this
let g:airline_theme = "tokyonight" " material OR deus OR bubblegum

" enable/disable enhanced tabline. (c)
let g:airline#extensions#tabline#enabled = 1

" configure the minimum number of tabs needed to show the tabline.
let g:airline#extensions#tabline#tab_min_count = 2

" enable/disable displaying buffers with a single tab. (c)
let g:airline#extensions#tabline#show_buffers = 0

" configure whether buffer numbers should be shown.
" let g:airline#extensions#tabline#buffer_nr_show = 1

" configure how buffer numbers should be formatted with |printf()|.
" let g:airline#extensions#tabline#buffer_nr_format = '[%s]::'

" configure whether close button should be shown:
let g:airline#extensions#tabline#show_close_button = 0

" configure how numbers are displayed in tab mode.
let g:airline#extensions#tabline#tab_nr_type = 2 " splits and tab number

" enable/disable detection of whitespace errors.
let g:airline#extensions#whitespace#enabled = 0

"" enable/disable syntastic integration
"let g:airline#extensions#syntastic#enabled = 1
" -----------------------------------------------------------------------------------------------------------
" =========================================================================================================================================

" ===== WSL yank support ========================================================================
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
" ===============================================================================================
