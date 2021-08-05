let loaded_netrw = 0
syntax on
filetype plugin indent on
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
if g:os == "Windows"
  set title
  let $PATH = "C:\\Program\ Files\\Git\\usr\\bin;" . $PATH " set bash on Windows path
else
  let $LANG = "en_US.UTF-8"
endif
au VimResized * wincmd =
au TermOpen * setlocal nonumber norelativenumber signcolumn=no
au TermOpen term://* startinsert
