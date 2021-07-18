" ===== DEFAULT ==============================================================
" An example for a vimrc file.
" copied from $VIMRUNTIME/vimrc_example.vim

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 168 characters.
  autocmd FileType text setlocal textwidth=168
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
" =============================================================================

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
Plug 'bfrg/vim-cpp-modern' " Keyword and regex-based syntax highlighting for C and C++11/14/17/20 in Vim.

" ----- LSP (ale & deoplete) ------------------------------------------
Plug 'dense-analysis/ale' " ALE (Asynchronous Lint Engine) is a plugin providing linting (syntax checking and semantic errors) 
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

" ----- UI ----------------------------------------------------------------------------------------------------
Plug 'morhetz/gruvbox' " Retro groove color scheme for Vim
Plug 'NLKNguyen/papercolor-theme' " Light & Dark color schemes for terminal and GUI Vim awesome editor
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
syntax on
colorscheme material " PaperColor or gruvbox or material
:set list lcs=tab:\|\ " show vertical guide lines between braces
:set background=dark " (dark OR light) 
:set number relativenumber 
:set autoindent
:set smartindent
:set showcmd
:set ignorecase " to search case-INsensitive
:set smartcase " requires ignorcase
:set incsearch " highlight all pattern matches while typing the search-string
:set hlsearch " highlight search result (after pressing ENTER)
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
" ctrl-c to copy the selected text to the clipboard
vnoremap <C-c> "+y 

inoremap {<CR> {<CR>}<ESC>ko

" adding (C++) multi-line comment 
vnoremap ? xi/**/<Esc>hP

" switch tabs in RHS-direction
nnoremap <Tab> :tabn<cr>
" swithch tabs in LHS-direction
nnoremap <S-Tab> :tabp<cr>

" open vertical terminal to the right
nnoremap tt :rightbelow vert term<cr>
" ------------------------------------------------------
" =============================================================================

" ===== PLUGIN CONFIGURATIONS =============================================================================================================
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

" ----- gruvbox theme ---------------------------------------
" Changes dark mode contrast
let g:gruvbox_contrast_dark='medium' " soft OR medium OR hard
" -----------------------------------------------------------

" ----- material theme --------------
let g:material_terminal_italics = 1
let g:material_theme_style = 'darker'
" -----------------------------------

" ----- vim-commentary -----------------------------
autocmd FileType c,cpp setlocal commentstring=//\ %s
" --------------------------------------------------

" ----- deoplete ------------------------------
let g:deoplete#enable_at_startup = 1

" Use ALE as completion sources for all code.
call deoplete#custom#source('ale', 'rank', 999)
" ---------------------------------------------

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
