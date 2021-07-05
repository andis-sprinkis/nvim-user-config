let loaded_netrw = 0
syntax on
filetype plugin indent on
if g:os == "Windows" | set title | endif
if g:os != "Windows" | let $LANG = "en_US.UTF-8"| endif
if g:os == "Windows" | let $PATH = "C:\\Program\ Files\\Git\\usr\\bin;" . $PATH | endif " set bash on Windows path
set noshowmode
set mouse=a
set splitbelow splitright
set winblend=10
set encoding=utf-8
set foldmethod=syntax foldlevel=99
set hidden " hidden bufers
set nohlsearch
set signcolumn=yes:2
set fcs=eob:\  " hide empty line indicator
set termguicolors
set number
set relativenumber
set wildmenu wildmode=longest:list,full
set list listchars=eol:¶,tab:»\ 
set nobackup nowritebackup
set noswapfile
set updatetime=100
set clipboard=unnamedplus
