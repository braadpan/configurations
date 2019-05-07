set hidden		" Enable unsaved file switching
set wildmenu		" Better command line completion
set autoindent		" Always set autoindenting on
set nrformats= 		" Numerals as decimals.
set number 		" Line numbers
set hlsearch 		" Highlight searches
set showcmd		" Show partial commands in last line 
set ignorecase		" Ignore case in search
set smartcase		" Except when using capitals
set ruler		" Show cursor position in last line
set laststatus=2 	" Always display status line
set cmdheight=2		" Set command height to 2 
set showmatch		" Show matching bracket
set mouse=a		" Enable mouse for all modes
set nowrap 		" Disable wrapping

" Cursor
" set guicursor=n-v-c:block-Cursor
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif
" execute pathogen#infect()

" Set leader
let mapleader = " "

" Go to normal mode
inoremap jj <ESC>

" Remove search highlight
nnoremap <leader><space> :noh<CR>

nnoremap <silent> [a :previous<CR>
nnoremap <silent> ]a :next<CR>
nnoremap <silent> [A :first<CR>
nnoremap <silent> ]A :last<CR>

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

nnoremap <silent> [t :tprevious<CR>
nnoremap <silent> ]t :tnext<CR>
nnoremap <silent> [T :tfirst<CR>
nnoremap <silent> ]T :tlast<CR>

