" ===== Vim-Plug Manager =================================================================================
call plug#begin('~/.vim/plugged')

" ----- EDIT --------------------------------------------------------------------------------------------------
Plug 'maxboisvert/vim-simple-complete' " Provides autocompletion suggestion while you type (it just uses vim's built-in autocomplete feature)
Plug 'dense-analysis/ale' " ALE (Asynchronous Lint Engine) is a plugin providing linting (syntax checking and semantic errors)
Plug 'mg979/vim-visual-multi', {'branch': 'master'} " A mulit-cursor plugin
Plug 'tpope/vim-fugitive' " a git plugin for vim
Plug 'tpope/vim-surround' " plugin for quoting/paranthesizing

" ----- Language Specific ------------------------------------------------------------------------------------
Plug 'bfrg/vim-cpp-modern' " Keyword and regex-based syntax highlighting for C and C++11/14/17/20 in Vim.
Plug 'rip-rip/clang_complete' " Vim plugin that use clang for completing C/C++ code

" ----- UI ----------------------------------------------------------------------------------------------------
Plug 'morhetz/gruvbox' " Retro groove color scheme for Vim
Plug 'NLKNguyen/papercolor-theme' " Light & Dark color schemes for terminal and GUI Vim awesome editor
Plug 'kaicataldo/material.vim', { 'branch': 'main' } " A port of the Material color scheme for Vim/Neovim.
Plug 'vim-airline/vim-airline' " Lean & mean status/tabline for vim
Plug 'vim-airline/vim-airline-themes' " Official themes for vim-airline (vim-airline must be installed)
Plug 'ryanoasis/vim-devicons' " add icons (always load devicons as the very last plugin)

call plug#end()
" plugin-specific configuration are at the end of the script
" ============================================================================================================

" ===== file/language specific compilation configuration ==================================
" not exactly sure of the working of `autocmd FileType` for now (so be careful)
autocmd FileType cpp nnoremap <C-B> :!makecp %<cr>
" actually mapped CTRL-/, linux recognizes CTRL-/ as CTRL-_
autocmd FileType cpp nnoremap <C-_> :!tcase %<cr>
autocmd FileType python nnoremap <C-B> :!python3 %<cr>
" =========================================================================================

" show vertical guide lines between braces
:set list lcs=tab:\|\ 
":set listchars=tab:\|\ 
":set list

syntax on
colorscheme PaperColor " PaperColor or gruvbox or material
set background=dark " (dark OR light) 
set number relativenumber 
set autoindent
set smartindent
set showcmd
set ignorecase
set smartcase " requires ignorcase
set incsearch " highlight all pattern matches while typing the patter 
set hlsearch " highlight search result (after pressing ENTER)
set autowrite 
set nowrap 
set tabstop=4
set shiftwidth=4
set showmatch
set cursorline " highlight the ROW on which the cursor is
set cursorcolumn " highlight the COLUMN on which the cursor is

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,InsertLeave,WinEnter * if &nu | set rnu   | endif
:  autocmd BufLeave,InsertEnter,WinLeave   * if &nu | set nornu | endif
:augroup END

" ctrl-a to select all 
noremap <C-a> <Esc>ggvG$ 
" ctrl-c to copy the selected text to the clipboard
vnoremap <C-c> "+y 

inoremap {<CR> {<CR>}<ESC>ko

" adding (C++) multi-line comment 
vnoremap ? xi/**/<Esc>hP
" (C++) comment selected lines
vnoremap / <C-v>I//<Esc>i

" switch tabs in RHS-direction
nnoremap <Tab> :tabn<cr>
" swithch tabs in LHS-direction
nnoremap <S-Tab> :tabp<cr>

" open vertical terminal to the right
nnoremap tt :rightbelow vert term<cr>

" fixing E349 error (probably)
let g:TerminusFocusReporting=0

" Plugin-specific Configurations
" ===== gruvbox configuration ===================
" Changes dark mode contrast
let g:gruvbox_contrast_dark='medium' " soft OR medium OR hard
" =============================================================

" ===== clang_complete configuration ===================
let g:clang_library_path='/usr/lib/llvm-10/lib/libclang-10.so.1'

" If equal to 1, the preview window will close automatically after a completion
let g:clang_close_preview='1'
" ====================================================================

" ===== ale configuration ============================================
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
" =========================================================================

" ==== vim airline configurations ==========================================================
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
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
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
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'

"------------------------------------
" deus theme (check out available airline themes:https://github.com/vim-airline/vim-airline/wiki/Screenshots)
" vim-airline themes is needed for this
let g:airline_theme='deus' " material OR deus OR bubblegum

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

" -------------------------- airline-ale configurations --------------------------
let airline#extensions#ale#error_symbol = "\uf05e :"
let airline#extensions#ale#warning_symbol = "\uf071 :"
" ==========================================================================================

" ===== material theme configurations ============================================================
let g:material_terminal_italics = 1
"let g:material_theme_style = 'darker'
" ================================================================================================
