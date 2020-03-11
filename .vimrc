syntax on           " Enable syntax highlighting
filetype plugin indent on

set background=dark
colorscheme gruvbox8

set nocompatible       " No idea why
set hidden             " Enable unsaved file switching
set wildmenu           " Better command line completion
set autoindent         " Always set autoindenting on
set nrformats=         " Numerals as decimals.
set number             " Line numbers
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
set formatoptions-=cro " Disables automatic comment insertion

" Tab settings
filetype plugin indent on   " Filetype specific tab setting
set tabstop=4               " Show tab as 4 spaces
set shiftwidth=4            " Use 4 spaces when indenting with >
set expandtab               " Insert spaces when tabbing

" Cursor settings
autocmd InsertEnter,InsertLeave * set cul!

" Open new split to the right and bottom
set splitbelow
set splitright

" Set leader to space
let mapleader = " "

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

" Remapping
nnoremap [a :previous<CR>
nnoremap ]a :next<CR>
nnoremap [A :first<CR>
nnoremap ]A :last<CR>
" Buffer remapping
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
nnoremap [B :bfirst<CR>
nnoremap ]B :blast<CR>
" Tab remapping
nnoremap [t :tprevious<CR>
nnoremap ]t :tnext<CR>
nnoremap [T :tfirst<CR>
nnoremap ]T :tlast<CR>

" Set syntax for .do files to tcl
autocmd BufNewFile,BufRead *.do set syntax=tcl

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
