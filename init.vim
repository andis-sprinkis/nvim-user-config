" leader key
let mapleader="\<space>"

" move over linebreak
nnoremap h <bs>
nnoremap l <space>
vnoremap h <bs>
vnoremap l <space>
 
" disbable default mode indicator
set noshowmode

" enable mouse integration
set mouse=a

" set split directions
set splitbelow
set splitright

" auto equal splits on resize
autocmd VimResized * wincmd =

" resize splits
nnoremap <silent><C-A-j> :resize +2<cr>
nnoremap <silent><C-A-k> :resize -2<cr>
nnoremap <silent><C-A-l> :vertical resize +4<cr>
nnoremap <silent><C-A-h> :vertical resize -4<cr>

" quicker split switching
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

" creating splits
nnoremap <silent><leader>s :split<cr>
nnoremap <silent><leader>vs :vsplit<cr>

" close window
nnoremap <C-q> :q<CR>

" set default encoding
set encoding=utf-8

" hidden bufers
set hidden

" no search highlight
set nohlsearch

" colors
"set termguicolors
set background=dark
colorscheme peachpuff

" syntax checking
syntax on

" hide empty line indicator
set fcs=eob:\ 

" line numbers
set number
set relativenumber

" command line completion
set wildmenu
set wildmode=longest:list,full

" tabs and spaces
set tabstop=2 shiftwidth=2 expandtab

" dispay special chars
"set listchars=eol:⦙,tab:»\ 
set listchars=space:·,trail:·,eol:↲,tab:»\ 
set list

" terminal buffer settings
au TermOpen * setlocal nonumber norelativenumber signcolumn=no

" unfocus terminal
tnoremap <C-w> <C-\><C-n>

" disable swp-ing
set noswapfile

" No 'Press Enter to continue'
set shortmess+=c

" clipboard system register
set clipboard=unnamedplus

" netrw
nnoremap <silent><nowait>- :Explore<cr>
let g:netrw_liststyle= 1

" switch buffers
nnoremap <silent><leader>b :set nomore <Bar> :ls <Bar> :set more <CR>:b<Space>

" folding
set foldmethod=syntax
set foldlevel=99
