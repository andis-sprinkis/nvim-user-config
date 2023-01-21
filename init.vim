colorscheme lunaperche
let $LANG = 'en_US.UTF-8'
let g:man_hard_wrap = 1
let g:netrw_liststyle= 1
let mapleader="\<space>"
set breakindent
set clipboard=unnamedplus
set cursorline
set expandtab
set foldlevel=99
set foldmethod=syntax
set list
set listchars=space:·,trail:·,eol:↲,tab:»\ 
set mouse=a
set nobackup
set nohlsearch
set noshowmode
set noswapfile
set nowritebackup
set number
set pumblend=10
set relativenumber
set scrolljump=-100
set shiftwidth=2
set shortmess+=c
set tabstop=2
set termguicolors
set title
set titlelen=1000
set updatetime=100
set winblend=10
syntax on

au FileType help setlocal signcolumn=no
au FileType man setlocal signcolumn=no

au TermOpen * setlocal nonumber norelativenumber signcolumn=no
au TermOpen term://* startinsert

au VimResized * wincmd =

nnoremap h <bs>
nnoremap l <space>
vnoremap h <bs>
vnoremap l <space>

nnoremap ; :
vnoremap ; :

nnoremap <silent><C-A-j> :resize +2<cr>
nnoremap <silent><C-A-k> :resize -2<cr>
nnoremap <silent><C-A-l> :vertical resize +4<cr>
nnoremap <silent><C-A-h> :vertical resize -4<cr>

nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

nnoremap <silent><leader>v :split<cr>
nnoremap <silent><leader>o :vsplit<cr>

nnoremap <C-q> :q<CR>

tnoremap <C-w> <C-\><C-n>

nnoremap <silent><nowait>- :Explore<cr>

nnoremap <silent><leader>b :set nomore <Bar> :ls <Bar> :set more <CR>:b<Space>
