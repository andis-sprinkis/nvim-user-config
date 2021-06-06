" Bootstrap Plug
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs 
    \ "https://raw.githubusercontent.com/andis-sprinkis/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

" load plugins
call plug#begin()
" statusline
Plug 'andis-sprinkis/lightline.vim'
" lightline-theme
Plug 'andis-sprinkis/lightline-gruvbox-dark.vim'
" VSCode plugins
Plug 'andis-sprinkis/coc.nvim', {'branch': 'release'}
" snippets
Plug 'andis-sprinkis/vim-snippets'
" indent indicator line
Plug 'andis-sprinkis/indentLine'
" general syntax highlighintg
Plug 'andis-sprinkis/vim-polyglot'
" commenting
Plug 'andis-sprinkis/vim-commentary'
" sudo
Plug 'andis-sprinkis/suda.vim'
" directory browser
Plug 'andis-sprinkis/vim-dirvish'
" git general integration
Plug 'andis-sprinkis/vim-fugitive'
" git indicators in gutter
Plug 'andis-sprinkis/vim-gitgutter'
" git commit messages under cursor
Plug 'andis-sprinkis/git-messenger.vim'
" color scheme
Plug 'andis-sprinkis/vim-gruvbox8'
" git hunks in lightline
Plug 'andis-sprinkis/lightline-hunks'
" buffer cycling and list
Plug 'andis-sprinkis/bufstop'
" fzf integration
if g:os == "Windows" || g:os == "Darwin"
  Plug 'andis-sprinkis/fzf', { 'do': { -> fzf#install() } }
endif
Plug 'andis-sprinkis/fzf.vim'
" common *nix actions
Plug 'andis-sprinkis/vim-eunuch'
" split between single and multiline forms
Plug 'andis-sprinkis/splitjoin.vim'
" read editorconfig
Plug 'andis-sprinkis/editorconfig-vim'
" surround chars with chars
Plug 'andis-sprinkis/vim-surround'
" jump to references and definitions in files
Plug 'andis-sprinkis/any-jump.vim'
" generate jsdoc block
Plug 'andis-sprinkis/vim-jsdoc', { 
  \ 'for': ['javascript', 'javascript.jsx','typescript'], 
  \ 'do': 'make install'
\ }
" detect document indentation
Plug 'andis-sprinkis/vim-sleuth'
" higlight word under cursor
Plug 'andis-sprinkis/vim-illuminate'
" move visual selection
Plug 'andis-sprinkis/vim-MvVis'
" more granular word motions
Plug 'andis-sprinkis/vim-wordmotion'
" highlight patterns and ranges for Ex commands
Plug 'andis-sprinkis/traces.vim'
" table creation
Plug 'andis-sprinkis/vim-table-mode'
" markdown preview
Plug 'andis-sprinkis/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
call plug#end()

" coc.nvim extensions
let g:coc_global_extensions = [
  \ "coc-tsserver",
  \ "coc-highlight",
  \ "coc-snippets",
  \ "coc-json",
  \ "coc-eslint", 
  \ "coc-html",
  \ "coc-css"
\ ]
