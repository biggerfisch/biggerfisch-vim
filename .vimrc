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
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Map Ctrl+n to toggle NERDTree on all tabs
map <C-n> :NERDTreeTabsToggle<CR>
" Map Ctrl+m to open current file in NerdTree
nnoremap <C-m> :NERDTreeFind<CR>
" Close vim if only a NERDTree is left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

""" vim-devicons
set encoding=utf8
let g:airline_powerline_fonts = 1
if has("win32") || has("win16")
    " Windows
    set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h13
else
    let os = substitute(system('uname'), "\n", "", "")
    if os == "Linux"
        " Linux
        set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 13
    elseif os == "Darwin"
        " OS X
        set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h13
    endif
endif


""" vim-airline config
" Display open buffers if only one tab page is open
let g:airline#extensions#tabline#enabled = 1
" No silly characters separators 
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline_left_sep=''
let g:airline_right_sep=''
" I don't care about trailing whitespace, so only enable indent checking.
" default: let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing' ]
let g:airline#extensions#whitespace#checks = [ 'indent' ]
" Always display status line
set laststatus=2

"""" vim-notes
let g:notes_directories = ['~/Box Sync/notes']
let g:notes_suffix = '.txt'
let g:notes_smart_quotes = 1
let g:notes_list_bullets = ['•', '◦', '▸', '▹', '▪', '▫']

""" Vim-gitgutter
let g:gitgutter_max_signs = 1000  " default value = 500

""" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$|\v[\/]node_modules|\v[\/]_site',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': '',
  \ }

" If no files to open, open ctrlp
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | CtrlP | endif

""" undotree
if has("persistent_undo")
    set undodir=~/.vim/.undodir
    set undofile
endif

""" dbext

" PUT DBEXT CONFIG HERE OR IN ~/??/.vimbiggerfischlocal

""" ********************************************************************************************************************
""" **************************************** Personal recommended settings *********************************************
""" ********************************************************************************************************************
" Use tab characters and let them be 4 characters wide
set tabstop=4
set shiftwidth=4
set expandtab " replaces tabs with spaces
""" Two-space indentation for coffeescript
autocmd BufNewFile,BufReadPost *.coffee setl ts=2 shiftwidth=2 expandtab
""" Two-space indentation for DocNetwork JS
autocmd BufNewFile,BufReadPost ~/doc/* setl ts=2 sw=2 sts=2 expandtab
autocmd BufNewFile,BufReadPost ~/dn/* setl ts=2 sw=2 sts=2 expandtab

""" Makefiles need tabs
autocmd BufNewFile,BufReadPost Makefile setl ts=2 shiftwidth=2 noexpandtab

""" Markdown settings
autocmd BufNewFile,BufReadPost *.md setl spell spelllang=en_us

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

    " Sets background transparent
    highlight Normal ctermbg=none
endif

" folding

" coffeescript folds by indentation
autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable

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
if os == "Linux"
    " Linux
    set clipboard=unnamedplus
    """ allows copying a github link to clipboard register
    let g:vimgurl_yank_register = '+'
elseif os == "Darwin"
    " OS X
    set clipboard=unnamed
    """ allows copying a github link to clipboard register
    let g:vimgurl_yank_register = '*'
else
    set clipboard=unnamedplus
endif

" Line length. (max == 120). Set to 121 to put the red line AFTER the last allowed column
set colorcolumn=121

""" settings for YouCompleteMe
" Use syntax for completions
let g:ycm_seed_identifiers_with_syntax = 1
" Close that stupid complete window after using the suggestion
let g:ycm_autoclose_preview_window_after_completion = 1

""" local vimrc
" strange name to prevent generalized attacks via `.vimrc`
let g:localvimrc_name=".vimbiggerfischlocal"
" since I name them strangely no need to ask
let g:localvimrc_ask=0

""" testfile
let g:testfile_search_expr = '\(.*\)\(js\|coffee\)$'
let g:testfile_replace_expr = '__tests__/\1unit.\2'

""" It seems that due to some interaction with NerdTree, closing a buffer with a NerdTree open causes vim to quit
""" This attempts to solve that by switching back to the prev buffer before closing one
cnoreabbrev bd bp<bar>bd#

""" Templates
augroup templates
    " Auto read in the skeleton of the currect extension, if it exists
    autocmd BufNewFile *.* silent! execute '0r ~/.vim/templates/skeleton.'.expand("<afile>:e")
augroup END

""" ********************************************************************************************************************
""" ****************************************           Mappings            *********************************************
""" ********************************************************************************************************************
" Map leader to space
let mapleader = "\<Space>"

" Buffer mappings
"map bn :bn<CR>
"map bN :bp<CR>
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

""" Function for format JSON
function! FormatJSON()
:%!python -m json.tool
endfunction

""" Toggle undotree view
nnoremap <F7> :UndotreeToggle<CR>

""" Highlights
" HL current line
nnoremap <silent> <Leader>l :exe "let m = matchadd('WildMenu','\\%" . line('.') . "l')"<CR>
" clear HLs
nnoremap <silent> <Leader><CR> :call clearmatches()<CR>

""" Enables SAFE execution of project specific vimrcs. SHOULD STILL CHECK
""" EVERY SINGLE PROJECT FOR VIMRCs YOU DO NOT CREATE.
set secure

nnoremap <Leader>j A<CR>console.log('<ESC>pa', <ESC>pa);<ESC>==
nnoremap <Leader>T :call testfile#FindAndOpenExisting()<CR>

let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
