" Bootstrap Plug
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs 
    \ "https://raw.githubusercontent.com/andis-sprinkis/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

" Plug plugins
call plug#begin()
" 'lifepillar/vim-gruvbox8
Plug 'andis-sprinkis/vim-gruvbox8'
" 'itchyny/lightline.vim'
Plug 'andis-sprinkis/lightline.vim'
" 'andis-sprinkis/lightline-gruvbox-dark.vim'
Plug 'andis-sprinkis/lightline-gruvbox-dark.vim'
" 'neoclide/coc.nvim'
Plug 'andis-sprinkis/coc.nvim', {'branch': 'release'}
" 'honza/vim-snippets'
Plug 'andis-sprinkis/vim-snippets'
" 'Yggdroot/indentLine'
Plug 'andis-sprinkis/indentLine'
" 'sheerun/vim-polyglot'
Plug 'andis-sprinkis/vim-polyglot'
" 'tpope/vim-commentary'
Plug 'andis-sprinkis/vim-commentary'
" 'lambdalisue/suda.vim'
Plug 'andis-sprinkis/suda.vim'
" 'justinmk/vim-dirvish'
Plug 'andis-sprinkis/vim-dirvish'
" 'tpope/vim-fugitive'
Plug 'andis-sprinkis/vim-fugitive'
" 'airblade/vim-gitgutter'
Plug 'andis-sprinkis/vim-gitgutter'
" 'sineto/lightline-hunks'
Plug 'andis-sprinkis/lightline-hunks'
" 'rhysd/git-messenger.vim'
Plug 'andis-sprinkis/git-messenger.vim'
" 'mihaifm/bufstop'
Plug 'andis-sprinkis/bufstop'
" 'junegunn/fzf'
if g:os == "Windows" || g:os == "Darwin" | Plug 'andis-sprinkis/fzf', { 'do': { -> fzf#install() } } | endif
" 'junegunn/fzf.vim'
Plug 'andis-sprinkis/fzf.vim'
" 'tpope/vim-eunuch'
Plug 'andis-sprinkis/vim-eunuch'
" 'AndrewRadev/splitjoin.vim'
Plug 'andis-sprinkis/splitjoin.vim'
" 'editorconfig/editorconfig-vim'
Plug 'andis-sprinkis/editorconfig-vim'
" 'pechorin/any-jump.vim'
Plug 'andis-sprinkis/any-jump.vim'
" 'heavenshell/vim-jsdoc'
Plug 'andis-sprinkis/vim-jsdoc', { 'for': ['javascript', 'javascript.jsx','typescript'], 'do': 'make install' }
" 'tpope/vim-sleuth'
Plug 'andis-sprinkis/vim-sleuth' 
" 'RRethy/vim-illuminate'
Plug 'andis-sprinkis/vim-illuminate'
" 'Jorengarenar/vim-MvVis'
Plug 'andis-sprinkis/vim-MvVis'
" 'markonm/traces.vim'
Plug 'andis-sprinkis/vim-wordmotion'
" 'markonm/traces.vim'
Plug 'andis-sprinkis/traces.vim'
" 'dhruvasagar/vim-table-mode'
Plug 'andis-sprinkis/vim-table-mode'
" 'iamcco/markdown-preview.nvim'
Plug 'andis-sprinkis/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
" 'antoinemadec/FixCursorHold.nvim'
Plug 'andis-sprinkis/FixCursorHold.nvim'
" 'cdelledonne/vim-cmake'
Plug 'andis-sprinkis/vim-cmake'
" 'alepez/vim-gtest'
Plug 'andis-sprinkis/vim-gtest'
call plug#end()

" coc.nvim Plugins
let g:coc_global_extensions = [
  \ "coc-tsserver",
  \ "coc-highlight",
  \ "coc-snippets",
  \ "coc-json",
  \ "coc-eslint", 
  \ "coc-html",
  \ "coc-css"
\ ]
