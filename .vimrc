""" Pathogen start
execute pathogen#infect()
" Recommended settings
syntax on
filetype plugin indent on

""" NERDTree config
" If no files given, open a NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Map Ctrl+n to toggle NERDTree on all tabs
map <C-n> :NERDTreeTabsToggle<CR>
" Close vim if only a NERDTree is left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Store session
set sessionoptions+=resize,winpos,buffers,tabpages,options
autocmd VimLeave * :mksession! ~/.vim/Session.vim
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | :source ~/.vim/Session.vim | :bd 1 | endif

""" vim-airline config
" Display open buffers if only one tab page is open
let g:airline#extensions#tabline#enabled = 1
" Always display status line
set laststatus=2

""" Personal recommended settigns
" Use tab characters and lett hem be 4 characters wide
set tabstop=4
set shiftwidth=4
" Line numbers
set number
" Preferred colorscheme
colorscheme 256-jungle

" buffer mappings
map bn :bn<CR>
map bN :bp<CR>
map <F5> :bp<CR>
map <F6> :bn<CR>
set hidden

" Force syntax highlighting again
syntax on

" folding  
augroup vimrc
	au BufReadPre * setlocal foldmethod=syntax
"	au BufWinEnter * if &fdm == 'syntax' | setlocal foldmethod=manual | endif
augroup END

" Start folds all open
set foldlevelstart=50

"These snippets set the fold mechanism so that inserting a new brace does not
"open random folds
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

