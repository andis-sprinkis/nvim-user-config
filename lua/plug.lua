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

if vim.g.plug_reqr.treesitter then
  vim.cmd([[
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  ]])
end

if vim.g.plug_reqr.lsp_plugins then
  vim.cmd([[
    Plug 'b0o/schemastore.nvim'
    Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer'
  ]])
end

if vim.g.plug_reqr.dap_plugins then
  vim.cmd([[
    Plug 'Pocco81/DAPInstall.nvim'
    Plug 'mfussenegger/nvim-dap'
    Plug 'theHamsta/nvim-dap-virtual-text'
  ]])
end

vim.cmd([[
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Jorengarenar/vim-MvVis'
Plug 'RRethy/vim-illuminate'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'chaoren/vim-wordmotion'
Plug 'dhruvasagar/vim-table-mode'
Plug 'editorconfig/editorconfig-vim'
Plug 'is0n/fm-nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'justinmk/vim-dirvish'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'markonm/traces.vim'
Plug 'mihaifm/bufstop'
Plug 'numToStr/Comment.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sleuth'
Plug 'tversteeg/registers.nvim'
Plug 'rafamadriz/friendly-snippets'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'David-Kunz/cmp-npm'
Plug 'hrsh7th/nvim-cmp'
Plug 'chrisbra/Colorizer'
Plug 'Mofiqul/vscode.nvim'
]])

if vim.g.plug_reqr.fzf_lua then vim.cmd([[Plug 'ibhagwan/fzf-lua']]) end
if vim.g.plug_reqr.fzf_vim then vim.cmd([[Plug 'junegunn/fzf.vim']]) end
if vim.g.plug_reqr.markdown_preview then vim.cmd([[Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}]]) end
if vim.g.plug_reqr.suda then vim.cmd([[Plug 'lambdalisue/suda.vim']]) end
if vim.g.plug_reqr.vim_doge then vim.cmd([[Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }]]) end
if vim.g.plug_reqr.nvim_spectre then vim.cmd([[Plug 'nvim-pack/nvim-spectre']]) end

vim.fn['plug#end']()
