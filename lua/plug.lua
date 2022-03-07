local autoload_plug_path = vim.fn.stdpath('data') .. '/site/autoload/plug.vim'
if vim.fn.filereadable(autoload_plug_path) == 0 then
  vim.cmd('!curl -fLo ' .. autoload_plug_path .. '  --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"')
  vim.cmd('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
end

if vim.fn.executable('git') == false then
  vim.g.nogitplugin = true
elseif vim.g.nogitplugin == nil then
  vim.g.nogitplugin = false
end

vim.g.sys_reqr = {
  dap_plugins = vim.g.os ~= 'Windows',
  fm_nvim = vim.fn.executable('lf') == 1,
  fzf = vim.g.os == 'Windows' or vim.g.os == 'Darwin',
  fzf_lua = vim.g.os ~= 'Windows',
  fzf_vim = vim.g.os == 'Windows' and (vim.fn.executable('bash') == 1),
  git_plugins = vim.g.nogitplugin == false,
  lsp_plugins = vim.fn.executable('node') == 1,
  markdown_preview = vim.fn.executable('node') == 1 or vim.fn.executable('yarn') == 1,
  nvim_spectre = vim.fn.executable('sed') == 1,
  suda_vim = vim.fn.executable('sudo') == 1,
  treesitter = vim.fn.executable('tree-sitter') == 1,
  vim_doge = vim.fn.executable('node') == 1,
}

vim.cmd([[
call plug#begin()

if g:sys_reqr['git_plugins']
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'tpope/vim-fugitive'
end

if g:sys_reqr['treesitter']
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
endif

if g:sys_reqr['lsp_plugins']
  Plug 'MunifTanjim/eslint.nvim'
  Plug 'MunifTanjim/prettier.nvim'
  Plug 'b0o/schemastore.nvim'
  Plug 'jose-elias-alvarez/null-ls.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer'
endif

if g:sys_reqr['dap_plugins']
  Plug 'Pocco81/DAPInstall.nvim'
  Plug 'mfussenegger/nvim-dap'
  Plug 'theHamsta/nvim-dap-virtual-text'
endif

if g:sys_reqr['fzf'] | Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } | endif
if g:sys_reqr['fzf_lua'] | Plug 'ibhagwan/fzf-lua' | endif
if g:sys_reqr['fzf_vim'] | Plug 'junegunn/fzf.vim' | endif
if g:sys_reqr['markdown_preview'] | Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} | endif
if g:sys_reqr['nvim_spectre'] | Plug 'nvim-pack/nvim-spectre' | endif
if g:sys_reqr['suda_vim'] | Plug 'lambdalisue/suda.vim' | endif
if g:sys_reqr['vim_doge'] | Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } } | endif

Plug 'lewis6991/impatient.nvim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'David-Kunz/cmp-npm'
Plug 'Jorengarenar/vim-MvVis'
Plug 'L3MON4D3/LuaSnip'
Plug 'Mofiqul/vscode.nvim'
Plug 'RRethy/vim-illuminate'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'chaoren/vim-wordmotion'
Plug 'chrisbra/Colorizer'
Plug 'dhruvasagar/vim-table-mode'
Plug 'editorconfig/editorconfig-vim'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'petertriho/cmp-git'
Plug 'is0n/fm-nvim'
Plug 'justinmk/vim-dirvish'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'markonm/traces.vim'
Plug 'mihaifm/bufstop'
Plug 'numToStr/Comment.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'rafamadriz/friendly-snippets'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sleuth'
Plug 'tversteeg/registers.nvim'

call plug#end()

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | q | endif
]])
