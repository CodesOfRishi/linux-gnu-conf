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

" ----- LSP (ale & vim-lsp) ------------------------------------------
Plug 'dense-analysis/ale' " ALE (Asynchronous Lint Engine) is a plugin providing linting (syntax checking and semantic errors)
Plug 'prabirshrestha/vim-lsp' " Async Language Server Protocol plugin for vim8 and neovim.
Plug 'mattn/vim-lsp-settings' " Auto configurations for Language Servers for vim-lsp.
Plug 'prabirshrestha/asyncomplete.vim' " to use auto-completion for vim-lsp
Plug 'prabirshrestha/asyncomplete-lsp.vim' " to use auto-completion for vim-lsp

" ----- UI ----------------------------------------------------------------------------------------------------
Plug 'kaicataldo/material.vim', { 'branch': 'main' } " A port of the Material color scheme for Vim/Neovim.
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
colorscheme material 
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

" To ALWAS use the clipboard for ALL operations 
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

" ----- ale ---------------------------------------------------------------------------------------
" This variable can be changed to use a different executable for a C++ compiler.
let g:ale_cpp_cc_executable='/usr/bin/g++'

" This variable can be change to modify flags given to the C++ compiler.
let g:ale_cpp_cc_options='-Wall -Wextra -O2 -fwrapv -Wshadow -Wfloat-equal -Wconversion -std=c++17'

let g:ale_sign_error="" " customized ale error sign
let g:ale_sign_warning="" " customized ale warning sign
"let g:ale_sign_error=""
"let g:ale_sign_warning=""
"let g:ale_sign_error="◉"
"let g:ale_sign_warning="◉"
highlight ALEErrorSign ctermfg=1
highlight clear ALEError
highlight clear ALEWarning
" -------------------------------------------------------------------------------------------------

" ----- vim-lsp -----------------------------------------------
"  registering python server
if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'allowlist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    inoremap <buffer> <expr><c-f> lsp#scroll(+4)
    inoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" using already installed lsp server for C++ (here, clangd-11)
let g:lsp_settings = {
\  'clangd': {'cmd': ['clangd-11']},
\  'efm-langserver': {'disabled': v:false}
\}

" disable diagnostic support (currently using ALE instead)
let g:lsp_diagnostics_enabled = 0

" CTRL-K & CTRL-J to navigate auto-completion list
inoremap <C-k> <Up>
inoremap <C-j> <Down>
" -------------------------------------------------------------

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
let g:airline_theme='material' " material OR deus OR bubblegum

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

" ----- ale airline ----------------------------------
let airline#extensions#ale#error_symbol = "\uf05e :"
let airline#extensions#ale#warning_symbol = "\uf071 :"
" ----------------------------------------------------
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
