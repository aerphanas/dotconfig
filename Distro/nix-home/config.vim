" ===============================
" =__   _(_)_ __ ___  _ __ ___  =
" =\ \ / / | '_ ` _ \| '__/ __| =
" = \ V /| | | | | | | | | (__  =
" =  \_/ |_|_| |_| |_|_|  \___| =
" ===============================
let mapleader =","
let maplocalleader="\<space>"
"set configuration
set wrap
set t_Co=256
set autoread
set autowrite
set noshowmode
set laststatus=2
set encoding=utf-8
set hlsearch
set foldmethod=syntax
set nofoldenable
set backspace=indent,eol,start " backspace over everything in insert mode

"noremap configuration
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <c-t> :m-2<cr>
noremap <c-d> :m+1<cr>
nnoremap <F4> :NumbersOnOff<CR>
nnoremap <F3> :NumbersToggle<CR>
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

map <F5> :Vexplore<CR>

"etc configuration
syntax on
colorscheme nord
autocmd BufWritePre * %s/\s\+$//e
let g:lightline = {'colorscheme': 'powerline'}
let g:UltiSnipsExpandTrigger="<tab>"
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" Fix for colemak.vim keymap collision. tpope/vim-fugitive's maps y<C-G>
" and colemak.vim maps 'y' to 'w' (word). In combination this stalls 'y'
" because Vim must wait to see if the user wants to press <C-G> as well.
augroup RemoveFugitiveMappingForColemak
    autocmd!
    autocmd BufEnter * silent! execute "nunmap <buffer> <silent> y<C-G>"
augroup END

" Reload vim-colemak to remap any overridden keys
silent! source "$HOME/.vim/plugged/vim-colemak/plugin/colemak.vim"

"map configuration
map <C-h> <C-w>h
map <C-n> <C-w>j
map <C-e> <C-w>k
map <C-i> <C-w>l
