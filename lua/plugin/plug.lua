local autoload_plug_path = vim.fn.stdpath('data') .. '/site/autoload/plug.vim'
if vim.fn.filereadable(autoload_plug_path) == 0 then
  vim.cmd('!curl -fLo ' .. autoload_plug_path .. '  --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"')
  vim.cmd('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
end

vim.fn['plug#begin']()

if vim.g.plug_reqr.git_plugins then
  vim.cmd([[
    Plug 'tpope/vim-fugitive'
    Plug 'lewis6991/gitsigns.nvim'
  ]])
end

vim.cmd([[
Plug 'nvim-lua/plenary.nvim'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'mihaifm/bufstop'
Plug 'editorconfig/editorconfig-vim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'tversteeg/registers.nvim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'markonm/traces.vim'
Plug 'Jorengarenar/vim-MvVis'
Plug 'numToStr/Comment.nvim'
Plug 'justinmk/vim-dirvish'
Plug 'tpope/vim-eunuch'
Plug 'lifepillar/vim-gruvbox8'
Plug 'RRethy/vim-illuminate'
Plug 'sheerun/vim-polyglot'
Plug 'honza/vim-snippets'
Plug 'dhruvasagar/vim-table-mode'
Plug 'chaoren/vim-wordmotion'
Plug 'is0n/fm-nvim'
]])

if vim.g.plug_reqr.fzf_install then vim.cmd([[Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }]]) end
if vim.g.plug_reqr.fzf_lua then vim.cmd([[Plug 'ibhagwan/fzf-lua']]) end
if vim.g.plug_reqr.fzf_vim then vim.cmd([[Plug 'junegunn/fzf.vim']]) end
if vim.g.plug_reqr.coc_nvim then vim.cmd([[Plug 'neoclide/coc.nvim', { 'branch': 'release' }]]) end
if vim.g.plug_reqr.markdown_preview then vim.cmd([[Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }]]) end
if vim.g.plug_reqr.suda then vim.cmd([[Plug 'lambdalisue/suda.vim']]) end
if vim.g.plug_reqr.vim_doge then vim.cmd([[Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }]]) end
if vim.g.plug_reqr.nvim_spectre then vim.cmd([[Plug 'nvim-pack/nvim-spectre']]) end

vim.fn['plug#end']()
