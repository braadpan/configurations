syntax on
colorscheme desert

set nocompatible    " No idea why
set hidden          " Enable unsaved file switching
set wildmenu        " Better command line completion
set autoindent      " Always set autoindenting on
set nrformats=      " Numerals as decimals.
set number          " Line numbers
set hlsearch        " Highlight searches
set showcmd         " Show partial commands in last line
set ignorecase      " Ignore case in search
set smartcase       " Except when using capitals
set ruler           " Show cursor position in last line
set laststatus=2    " Always display status line
set cmdheight=2     " Set command height to 2
set showmatch       " Show matching bracket
set mouse=a         " Enable mouse for all modes
set nowrap          " Disable wrapping

" Tab settings
filetype plugin indent on   " Filetype specific tab setting
set tabstop=4               " Show tab as 4 spaces
set shiftwidth=4            " Use 4 spaces when indenting with >
set expandtab               " Insert spaces when tabbing

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

" Convenient remappings
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

" Set syntax for .do files to tcl
autocmd BufNewFile,BufRead *.do set syntax=tcl

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