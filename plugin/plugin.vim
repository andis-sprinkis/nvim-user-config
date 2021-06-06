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

" Statusline
Plug 'andis-sprinkis/lightline.vim'

" lightline theme
Plug 'andis-sprinkis/lightline-gruvbox-dark.vim'

" Conquer of completion
Plug 'andis-sprinkis/coc.nvim', {'branch': 'release'}

" Snippets
Plug 'andis-sprinkis/vim-snippets'

" Indentation indicator
Plug 'andis-sprinkis/indentLine'

" Syntax highlighintg
Plug 'andis-sprinkis/vim-polyglot'

" Commenting
Plug 'andis-sprinkis/vim-commentary'

" sudo
Plug 'andis-sprinkis/suda.vim'

" Directory browser
Plug 'andis-sprinkis/vim-dirvish'

" git general integration
Plug 'andis-sprinkis/vim-fugitive'

" git indicators in gutter
Plug 'andis-sprinkis/vim-gitgutter'

" git commit messages under cursor
Plug 'andis-sprinkis/git-messenger.vim'

" Color scheme
Plug 'andis-sprinkis/vim-gruvbox8'

" git hunks in lightline
Plug 'andis-sprinkis/lightline-hunks'

" Buffer cycling and list
Plug 'andis-sprinkis/bufstop'

" fzf
if g:os == "Windows" || g:os == "Darwin"
  Plug 'andis-sprinkis/fzf', { 'do': { -> fzf#install() } }
endif
Plug 'andis-sprinkis/fzf.vim'

" Common *nix actions
Plug 'andis-sprinkis/vim-eunuch'

" Split between single and multiline forms
Plug 'andis-sprinkis/splitjoin.vim'

" Read editorconfig
Plug 'andis-sprinkis/editorconfig-vim'

" Surround chars with chars
" Plug 'andis-sprinkis/vim-surround'

" Jump to references and definitions in files
Plug 'andis-sprinkis/any-jump.vim'

" JSDoc
Plug 'andis-sprinkis/vim-jsdoc', { 
  \ 'for': ['javascript', 'javascript.jsx','typescript'], 
  \ 'do': 'make install'
\ }

" Detect document indentation
Plug 'andis-sprinkis/vim-sleuth'

" Higlight word under cursor
Plug 'andis-sprinkis/vim-illuminate'

" Move visual selection
Plug 'andis-sprinkis/vim-MvVis'

" More granular word motions
Plug 'andis-sprinkis/vim-wordmotion'

" Highlight patterns and ranges for Ex commands
Plug 'andis-sprinkis/traces.vim'

" Table creation
Plug 'andis-sprinkis/vim-table-mode'

" Markdown preview
Plug 'andis-sprinkis/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" Fix cursor hold
" Forked from 'antoinemadec/FixCursorHold.nvim'
Plug 'andis-sprinkis/FixCursorHold.nvim'

" CMake
" Forked from 'cdelledonne/vim-cmake'
Plug 'andis-sprinkis/vim-cmake'

" GoogleTest
" Forked from 'alepez/vim-gtest'
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
