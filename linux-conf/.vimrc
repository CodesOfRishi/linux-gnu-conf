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

" ===== Vim-Plug Manager ====================================================================================================================
call plug#begin('~/.vim/plugged')

" ----- EDIT --------------------------------------------------------------------------------------------------
Plug 'mg979/vim-visual-multi', {'branch': 'master'} " A mulit-cursor plugin
Plug 'tpope/vim-surround' " plugin for quoting/paranthesizing
Plug 'tpope/vim-commentary'

" ----- Searching -----
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'

" ----- Git ------------------------------------
Plug 'tpope/vim-fugitive' " a git plugin for vim
Plug 'airblade/vim-gitgutter' 

" ----- Language Specific ------------------------------------------------------------------------------------
Plug 'sheerun/vim-polyglot' " A collection of language packs for Vim.

" ----- LSP (coc.nvim) ------------------------------------------
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" ----- UI ----------------------------------------------------------------------------------------------------
Plug 'kaicataldo/material.vim', { 'branch': 'main' } " A port of the Material color scheme for Vim/Neovim.
Plug 'vim-airline/vim-airline' " Lean & mean status/tabline for vim 
Plug 'vim-airline/vim-airline-themes' " Official themes for vim-airline (vim-airline must be installed)
Plug 'ryanoasis/vim-devicons' " add icons (always load devicons as the very last plugin)

call plug#end()

" =============================================================================
" ----- file/language specific compilation configuration ----------------------
" not exactly sure of the working of `autocmd FileType` for now (so be careful)
autocmd FileType cpp nnoremap <C-B> :!makecp %<cr>
" actually mapped CTRL-/, linux recognizes CTRL-/ as CTRL-_
autocmd FileType cpp nnoremap <C-_> :!tcase %<cr>
autocmd FileType python nnoremap <C-_> :!python3 %<cr>

" -----------------------------------------------------------------------------
let g:material_terminal_italics = 1
let g:material_theme_style = 'palenight'
colorscheme material 

syntax on
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

" ----- vim-commentary -----------------------------
autocmd FileType c,cpp setlocal commentstring=//\ %s

" ---- coc -----------------------------------------------------------------------------
" TextEdit might fail if hidden is not set 
set hidden

" some servers have issues with backup files,
" {https://github.com/neoclide/coc.nvim/issues/649}
set nobackup
set nowritebackup

" give more space for displaying messages
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	  let col = col('.') - 1
	    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-@> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
    else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
	autocmd!
	" Setup formatexpr specified filetype(s).
	autocmd FileType cpp,python setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder.
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

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

" -----------------------------------------------------------------------------------------------------------
" deus theme (check out available airline themes:https://github.com/vim-airline/vim-airline/wiki/Screenshots)
" vim-airline themes is needed for this
let g:airline_theme='material' 

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

" ----- airline-coc -----------------------------
let airline#extensions#coc#error_symbol = ' :'
let airline#extensions#coc#warning_symbol = ' :'

" ===== WSL yank support ========================================================================
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
