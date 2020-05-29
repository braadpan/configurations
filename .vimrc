syntax on           " Enable syntax highlighting
filetype plugin indent on

" Colorscheme
set background=dark
colorscheme gruvbox8

set t_ut=              " Fix tmux/vim background issue
set t_Co=256           " Use 256 colors
set nocompatible       " No idea why
set hidden             " Enable unsaved file switching
set wildmenu           " Better command line completion
set autoindent         " Always set autoindenting on
set nrformats=         " Numerals as decimals.
set relativenumber     " Relative line numbers
set hlsearch           " Highlight searches
set showcmd            " Show partial commands in last line
set ignorecase         " Ignore case in search
set smartcase          " Except when using capitals
set ruler              " Show cursor position in last line
set laststatus=2       " Always display status line
set cmdheight=2        " Set command height to 2
set showmatch          " Show matching bracket
set mouse=a            " Enable mouse for all modes
set nowrap             " Disable wrapping
set scrolloff=3        " Minimum number of lines around cursor

" Auto reload file when changed
set autoread           
au CursorHold * checktime

" Tab settings
set tabstop=4               " Show tab as 4 spaces
set shiftwidth=4            " Use 4 spaces when indenting with >
set expandtab               " Insert spaces when tabbing

" Set leader to space
let mapleader = " "

" Disables automatic comment insertion
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro 

" Cursor settings
autocmd InsertEnter,InsertLeave * set cul!

" Set syntax for .do files to tcl
autocmd BufNewFile,BufRead *.do set syntax=tcl

" vimrc: auto reload and edit shortcut
autocmd bufwritepost .vimrc source $MYVIMRC
map <leader>v :split $MYVIMRC<cr>
 
" Open new split to the right and bottom
set splitbelow
set splitright

" Go to normal mode using jj
inoremap jj <ESC>

" Don't update register when using x
noremap x "_x

" Remove search highlight
nnoremap <leader><space> :noh<CR>

" Close buffer without closing window
map <leader>q :b#<bar>bd#<cr>

" Create blank newlines and stay in normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Easier switching between windows, allow control to be hold down
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Buffer remapping
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
" Tab remapping
nnoremap [t :tprevious<CR>
nnoremap ]t :tnext<CR>

" Open buffer list and open buffer 
nnoremap gb :ls<CR>:b<Space>

" netrw
let g:netrw_liststyle=3     " Tree view
let g:netrw_banner=0        " Remove banner
let g:netrw_browse_split=4  " Open in previous window
let g:netrw_winsize=25      " Set width to 25%

"==============================================================
" Save current view settings on a per-window, per-buffer basis.
function! AutoSaveWinView()
    if !exists("w:SavedBufView")
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction

" Restore current view settings.
function! AutoRestoreWinView()
    let buf = bufnr("%")
    if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
        let v = winsaveview()
        let atStartOfFile = v.lnum == 1 && v.col == 0
        if atStartOfFile && !&diff
            call winrestview(w:SavedBufView[buf])
        endif
        unlet w:SavedBufView[buf]
    endif
endfunction

" When switching buffers, preserve window view.
if v:version >= 700
    autocmd BufLeave * call AutoSaveWinView()
    autocmd BufEnter * call AutoRestoreWinView()
endif
"==============================================================
