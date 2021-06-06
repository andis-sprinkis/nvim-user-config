" window title
if g:os == "Windows"
  set title
endif

" disbable default mode indicator
set noshowmode

" enable mouse integration
set mouse=a

" set split directions
set splitbelow
set splitright

" auto equal splits on resize
autocmd VimResized * wincmd =

" floating window transparency
set winblend=10

" set default encoding
set encoding=utf-8

" folding
filetype plugin indent on
set foldmethod=syntax
set foldlevel=99

" hidden bufers
set hidden

" no search highlight
set nohlsearch

" colors
set termguicolors
set background=dark
colorscheme gruvbox8_hard
syntax on

" always show signcolumn
set signcolumn=yes:2

" hide empty line indicator
set fcs=eob:\ 

" line numbers
set number
set relativenumber

" command line completion
set wildmenu
set wildmode=longest:list,full

" dispay special chars
set listchars=eol:¶,tab:»\ 
set list

" Some servers have issues with backup files
set nobackup
set nowritebackup

" disable swp-ing
set noswapfile

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=100

" No 'Press Enter to continue'
set shortmess+=c

" clipboard system register
set clipboard=unnamedplus

" disable netrw
let loaded_netrw = 0

" terminal buffer settings
au TermOpen * setlocal nonumber norelativenumber signcolumn=no

" terminal auto insert mode
au TermOpen term://* startinsert

" centered floating window 
function! CreateCenteredFloatingWindow()
  let height = float2nr(&lines * 0.85)
  let top = ((&lines - height) / 2) - 1
  let width = float2nr(&columns - (&columns * 2 / 12))
  let left = float2nr((&columns - width) / 2)
  let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}
  let top = "╭" . repeat("─", width - 2) . "╮"
  let mid = "│" . repeat(" ", width - 2) . "│"
  let bot = "╰" . repeat("─", width - 2) . "╯"
  let lines = [top] + repeat([mid], height - 2) + [bot]
  let s:buf = nvim_create_buf(v:false, v:true)
  call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
  call nvim_open_win(s:buf, v:true, opts)
  set winhl=Normal:Floating
  let opts.row += 1
  let opts.height -= 2
  let opts.col += 2
  let opts.width -= 4
  call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
  au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

" tsconfig.json is actually jsonc, help TypeScript set the correct filetype
autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc

" disable markdown syntax highlighting
au FileType markdown set syntax=off
au FileType markdown.mdx set syntax=off

" leader key
let mapleader="\<space>"

" move over linebreak
nnoremap h <bs>
nnoremap l <space>
vnoremap h <bs>
vnoremap l <space>

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

" normal mode terminal
tnoremap <C-w> <C-\><C-n>
