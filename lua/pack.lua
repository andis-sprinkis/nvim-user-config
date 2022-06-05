vim.g.nogitplugin = (vim.fn.executable('git') == false) or vim.g.nogitplugin == true

vim.g.sys_reqr = {
  dap_plugins = vim.g.os ~= 'Windows',
  fm_nvim = vim.fn.executable('lf') == 1,
  fzf = vim.g.os == 'Windows' or vim.g.os == 'Darwin',
  fzf_lua = vim.g.os ~= 'Windows',
  fzf_vim = vim.g.os == 'Windows' and (vim.fn.executable('bash') == 1),
  git_plugins = vim.g.nogitplugin == false,
  lsp_plugins = vim.fn.executable('node') == 1,
  markdown_preview = vim.fn.executable('node') == 1,
  nvim_spectre = vim.fn.executable('sed') == 1,
  nvim_gfold_lua = vim.fn.executable('gfold') == 1,
  suda_vim = vim.fn.executable('sudo') == 1,
  treesitter = vim.fn.executable('tree-sitter') == 1,
  vim_doge = vim.fn.executable('node') == 1,
  vim_hexokinase = vim.fn.executable('go') == 1,
}

local packer_bootstrap
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
  packer_bootstrap = vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

require('packer').startup(function(use)
  use {
    {
      'lewis6991/impatient.nvim',
      config = function() require('impatient') end,
    },
    { 'stevearc/dressing.nvim' },
    { 'wbthomason/packer.nvim' },
    { 'nvim-lua/plenary.nvim' },
    { 'Jorengarenar/vim-MvVis' },
    { 'markonm/traces.vim' },
    { 'RRethy/vim-illuminate' },
    { 'antoinemadec/FixCursorHold.nvim' },
    { 'chaoren/vim-wordmotion' },
    { 'dhruvasagar/vim-table-mode' },
    { 'editorconfig/editorconfig-vim' },
    { 'tpope/vim-eunuch' },
    { 'tversteeg/registers.nvim' },
    { 'jghauser/mkdir.nvim' },
    {
      'jghauser/follow-md-links.nvim',
      cond = { vim.g.sys_reqr['treesitter'] },
      requires = { 'nvim-treesitter/nvim-treesitter' },
    },
    {
      'mrjones2014/smart-splits.nvim',
      config = require('plugin_post.smart_splits_nvim'),
    },
    {
      'stevearc/qf_helper.nvim',
      config = require('plugin_post.qf_helper_nvim'),
    },
    {
      'haringsrob/nvim_context_vt',
      cond = { vim.g.sys_reqr['treesitter'] },
      after = { 'nvim-treesitter' },
      config = require('plugin_post.nvim_context_vt_nvim'),
    },
    {
      'sindrets/winshift.nvim',
      config = require('plugin_post.winshift_nvim'),
    },
    {
      cond = { vim.g.sys_reqr['git_plugins'] },
      { 'tpope/vim-fugitive' },
      {
        'lewis6991/gitsigns.nvim',
        config = require('plugin_post.gitsigns_nvim'),
      },
      -- {
      --   "AckslD/nvim-gfold.lua",
      --   cond = { vim.g.sys_reqr['nvim_gfold_lua'] },
      --   config = require('plugin_post.nvim_gfold_lua'),
      -- }
    },
    {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      cond = { vim.g.sys_reqr['treesitter'] },
      config = require('plugin_post.nvim_treesitter'),
      requires = {
        { 'JoosepAlviste/nvim-ts-context-commentstring' },
        { 'nvim-treesitter/nvim-treesitter-textobjects' },
      }
    },
    {
      'm-demare/hlargs.nvim',
      cond = { vim.g.sys_reqr['treesitter'] },
      requires = { 'nvim-treesitter/nvim-treesitter' },
      config = require('plugin_post.hlargs_nvim'),
    },
    {
      'williamboman/nvim-lsp-installer',
      cond = { vim.g.sys_reqr['lsp_plugins'] },
      config = function()
        require('plugin_post.nvim_lsp_installer')()
        require('plugin_post.null_ls_nvim')()
      end,
      requires = {
        { 'b0o/schemastore.nvim' },
        { 'jose-elias-alvarez/null-ls.nvim' },
        { 'neovim/nvim-lspconfig' },
      },
    },
    {
      'mfussenegger/nvim-dap',
      cond = vim.g.sys_reqr['dap_plugins'],
      config = require('plugin_post.nvim_dap')
    },
    {
      'junegunn/fzf',
      cond = { vim.g.sys_reqr['fzf'] },
      run = function() vim.fn['fzf#install']() end,
    },
    {
      'ibhagwan/fzf-lua',
      cond = { vim.g.sys_reqr['fzf_lua'] },
      config = require('plugin_post.fzf_lua')
    },
    {
      'junegunn/fzf.vim',
      cond = { vim.g.sys_reqr['fzf_vim'] },
      config = require('plugin_post.fzf_vim')
    },
    {
      'is0n/fm-nvim',
      cond = { vim.g.sys_reqr['fm_nvim'] },
      config = require('plugin_post.fm_nvim')
    },
    {
      'nvim-pack/nvim-spectre',
      cond = { vim.g.sys_reqr['nvim_spectre'] },
      config = require('plugin_post.nvim_spectre'),
    },
    {
      'lambdalisue/suda.vim',
      cond = { vim.g.sys_reqr['suda_vim'] },
      config = require('plugin_post.suda'),
    },
    {
      'kkoomen/vim-doge',
      run = function() vim.fn['doge#install']() end,
      setup = require('plugin_post.vim_doge_setup'),
      cond = { vim.g.sys_reqr['vim_doge'] },
    },
    {
      'rrethy/vim-hexokinase',
      run = 'make hexokinase',
      cond = { vim.g.sys_reqr['vim_hexokinase'] },
    },
    {
      'iamcco/markdown-preview.nvim',
      cond = { vim.g.sys_reqr['markdown_preview'] },
      run = function() vim.fn['mkdp#util#install']() end,
      ft = { 'markdown', 'vim-plug' },
    },
    {
      'AndrewRadev/splitjoin.vim',
      config = require('plugin_post.splitjoin')
    },
    {
      'Mofiqul/vscode.nvim',
      config = require('plugin_post.colorscheme')
    },
    {
      'NMAC427/guess-indent.nvim',
      config = require('plugin_post.guess_indent_nvim')
    },
    {
      'notomo/cmdbuf.nvim',
      config = require('plugin_post.cmdbuf_nvim')
    },
    {
      'hrsh7th/nvim-cmp',
      requires = {
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },
        { 'dmitmel/cmp-cmdline-history' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'lukas-reineke/cmp-rg' },
        { 'David-Kunz/cmp-npm' },
        { 'petertriho/cmp-git' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-cmdline' },
        { 'hrsh7th/cmp-emoji' },
        { 'tamago324/cmp-zsh' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-path' },
      },
      config = require('plugin_post.nvim_cmp')
    },
    {
      'justinmk/vim-dirvish',
      config = require('plugin_post.dirvish')
    },
    {
      'lukas-reineke/indent-blankline.nvim',
      config = require('plugin_post.indent_blankline_nvim')
    },
    {
      'mihaifm/bufstop',
      config = require('plugin_post.bufstop')
    },
    {
      'numToStr/Comment.nvim',
      config = require('plugin_post.comment_nvim')
    },
  }

  if packer_bootstrap then require('packer').sync() end
end)

if vim.g.sys_reqr['git_plugins'] and vim.g.sys_reqr['lsp_plugins'] then require('plugin_post.statusline') end
