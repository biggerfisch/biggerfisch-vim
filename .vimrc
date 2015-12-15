""" Pathogen start
execute pathogen#infect()
" Recommended settings
syntax on
filetype plugin indent on

""" ********************************************************************************************************************
""" ****************************************         Plugin Config         *********************************************
""" ********************************************************************************************************************
""" NERDTree config
" If no files given, open a NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Map Ctrl+n to toggle NERDTree on all tabs
map <C-n> :NERDTreeTabsToggle<CR>
" Close vim if only a NERDTree is left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

""" vim-airline config
" Display open buffers if only one tab page is open
let g:airline#extensions#tabline#enabled = 1
" No silly characters separators 
let g:airline_left_sep=''
let g:airline_right_sep=''
" I don't care about trailing whitespace, so only enable indent checking.
" default: let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing' ]
let g:airline#extensions#whitespace#checks = [ 'indent' ]
" Always display status line
set laststatus=2

""" ********************************************************************************************************************
""" **************************************** Personal recommended settings *********************************************
""" ********************************************************************************************************************
" Use tab characters and lett hem be 4 characters wide
set tabstop=4
set shiftwidth=4
set expandtab " for use at work
" Line numbers
set number
" Allow switching from changed buffers
set hidden
" This lets the background color stay the same inside of tmux/screen
if &term =~ '256color'
	" disable Background Color Erase (BCE) so that color schemes
	" render properly when inside 256-color tmux and GNU screen.
	" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
	set t_ut=
	" Preferred colorscheme
	colorscheme 256-jungle
endif

" folding
augroup vimrc
	au BufReadPre * setlocal foldmethod=syntax
"	au BufWinEnter * if &fdm == 'syntax' | setlocal foldmethod=manual | endif
augroup END

" Start folds all open
set foldlevelstart=50

" These snippets set the fold mechanism so that inserting a new brace does not open random folds
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" Set mouse to auto mode (normally on, unless one isn't attached, which is purely your fault.)
set mouse=a

" Allow using the OS copy/paste. Requires vim compiled with +clipboard
" Note that if in tmux on OS X, you'll need other settings in tmux to make
" this work properly
set clipboard=unnamed

" Line length. (max == 120). Set to 121 to put the red line AFTER the last allowed column
set colorcolumn=121

""" settings for YouCompleteMe
" Use syntax for completions
let g:ycm_seed_identifiers_with_syntax = 1
" Close that stupid complete window after using the suggestion
let g:ycm_autoclose_preview_window_after_completion = 1

""" ********************************************************************************************************************
""" ****************************************           Mappings            *********************************************
""" ********************************************************************************************************************
" Map leader to space
let mapleader = "\<Space>"

" Buffer mappings
map bn :bn<CR>
map bN :bp<CR>
map <F5> :bp<CR>
map <F6> :bn<CR>
" Map in insert mode too
map! <F5> <ESC>:bp<CR> 
map! <F6> <ESC>:bn<CR>

" Search highlighting toggle.
let hlstate=0
nnoremap <F4> :let hlstate=1-hlstate \| if (hlstate == 0) \| nohlsearch \| else \| set hlsearch \| endif<CR>

" Map save to Space + W
nnoremap <Leader>w :w<CR>

