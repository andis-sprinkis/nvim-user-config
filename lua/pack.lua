vim.g.sys_reqr = {
  cmp_tmux = vim.fn.executable('tmux') == 1,
  cmp_zsh = vim.fn.executable('zsh') == 1,
  dap_plugins = vim.g.os ~= 'Windows',
  fm_nvim = vim.fn.executable('lf') == 1,
  fzf = vim.g.os == 'Windows' or vim.g.os == 'Darwin',
  fzf_lua = vim.g.os ~= 'Windows',
  fzf_vim = vim.g.os == 'Windows' and (vim.fn.executable('bash') == 1),
  git_plugins = vim.fn.executable('git') == 1,
  lsp_plugins = vim.fn.executable('node') == 1,
  markdown_preview = vim.fn.executable('node') == 1,
  nvim_spectre = vim.fn.executable('sed') == 1,
  suda_vim = vim.fn.executable('sudo') == 1,
  swenv = vim.fn.executable('python3') == 1,
  treesitter = vim.fn.executable('tree-sitter') == 1,
  vim_doge = vim.fn.executable('node') == 1,
  vim_hexokinase = vim.fn.executable('go') == 1,
}

local packer_bootstrap
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
  packer_bootstrap = vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
end

require('packer').startup(function(use)
  use {
    {
      'lewis6991/impatient.nvim',
      config = function() require('impatient') end,
    },
    {
      'AckslD/swenv.nvim',
      requires = { 'stevearc/dressing.nvim' },
      config = require('plugin.swenv_nvim'),
    },
    { 'stevearc/dressing.nvim' },
    { 'wbthomason/packer.nvim' },
    { 'nvim-lua/plenary.nvim' },
    { 'markonm/traces.vim' },
    { 'RRethy/vim-illuminate' },
    { 'chaoren/vim-wordmotion' },
    { 'dhruvasagar/vim-table-mode' },
    { 'editorconfig/editorconfig-vim' },
    { 'tpope/vim-eunuch' },
    { 'jghauser/mkdir.nvim' },
    { 'tversteeg/registers.nvim',
      config = require('plugin.registers_nvim')
    },
    {
      'jghauser/follow-md-links.nvim',
      cond = { vim.g.sys_reqr['treesitter'] },
      requires = { 'nvim-treesitter/nvim-treesitter' },
    },
    {
      "luukvbaal/stabilize.nvim",
      config = require('plugin.stabilize_nvim')
    },
    {
      'mrjones2014/smart-splits.nvim',
      config = require('plugin.smart_splits_nvim'),
    },
    {
      'haringsrob/nvim_context_vt',
      cond = { vim.g.sys_reqr['treesitter'] },
      after = { 'nvim-treesitter' },
      config = require('plugin.nvim_context_vt_nvim'),
    },
    {
      'sindrets/winshift.nvim',
      config = require('plugin.winshift_nvim'),
    },
    {
      cond = { vim.g.sys_reqr['git_plugins'] },
      { 'tpope/vim-fugitive' },
      {
        'lewis6991/gitsigns.nvim',
        config = require('plugin.gitsigns_nvim'),
      },
    },
    {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      cond = { vim.g.sys_reqr['treesitter'] },
      config = require('plugin.nvim_treesitter'),
      requires = {
        { 'JoosepAlviste/nvim-ts-context-commentstring' },
        { 'nvim-treesitter/nvim-treesitter-textobjects' },
      }
    },
    {
      'm-demare/hlargs.nvim',
      cond = { vim.g.sys_reqr['treesitter'] },
      requires = { 'nvim-treesitter/nvim-treesitter' },
      config = require('plugin.hlargs_nvim'),
    },
    {
      "williamboman/mason.nvim",
      cond = { vim.g.sys_reqr['lsp_plugins'] },
      config = require('plugin.mason_nvim'),
      requires = {
        { 'b0o/schemastore.nvim' },
        { 'jayp0521/mason-null-ls.nvim' },
        { 'jose-elias-alvarez/null-ls.nvim' },
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason-lspconfig.nvim' },
      }
    },
    {
      'mfussenegger/nvim-dap',
      cond = vim.g.sys_reqr['dap_plugins'],
      config = require('plugin.nvim_dap')
    },
    {
      'junegunn/fzf',
      cond = { vim.g.sys_reqr['fzf'] },
      run = function() vim.fn['fzf#install']() end,
    },
    {
      'ibhagwan/fzf-lua',
      cond = { vim.g.sys_reqr['fzf_lua'] },
      config = require('plugin.fzf_lua')
    },
    {
      'junegunn/fzf.vim',
      cond = { vim.g.sys_reqr['fzf_vim'] },
      config = require('plugin.fzf_vim')
    },
    {
      'is0n/fm-nvim',
      cond = { vim.g.sys_reqr['fm_nvim'] },
      config = require('plugin.fm_nvim')
    },
    {
      'nvim-pack/nvim-spectre',
      cond = { vim.g.sys_reqr['nvim_spectre'] },
      config = require('plugin.nvim_spectre'),
    },
    {
      'lambdalisue/suda.vim',
      cond = { vim.g.sys_reqr['suda_vim'] },
      config = require('plugin.suda'),
    },
    {
      'kkoomen/vim-doge',
      run = function() vim.fn['doge#install']() end,
      setup = require('plugin.vim_doge_setup'),
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
      config = require('plugin.splitjoin')
    },
    {
      'Mofiqul/vscode.nvim',
      config = require('plugin.colorscheme')
    },
    {
      'NMAC427/guess-indent.nvim',
      config = require('plugin.guess_indent_nvim')
    },
    {
      'hrsh7th/nvim-cmp',
      requires = {
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },
        { 'dmitmel/cmp-cmdline-history' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'David-Kunz/cmp-npm' },
        { 'petertriho/cmp-git' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-cmdline' },
        { 'hrsh7th/cmp-emoji' },
        { 'tamago324/cmp-zsh',
          cond = { vim.g.sys_reqr['cmp_zsh'] }
        },
        { 'andersevenrud/cmp-tmux',
          cond = { vim.g.sys_reqr.cmp_tmux }
        },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-path' },
      },
      config = require('plugin.nvim_cmp')
    },
    {
      'justinmk/vim-dirvish',
      config = require('plugin.dirvish')
    },
    {
      'lukas-reineke/indent-blankline.nvim',
      config = require('plugin.indent_blankline_nvim')
    },
    {
      'mihaifm/bufstop',
      config = require('plugin.bufstop')
    },
    {
      'numToStr/Comment.nvim',
      config = require('plugin.comment_nvim')
    },
    {
      "andrewferrier/debugprint.nvim",
      config = require('plugin.debugprint_nvim'),
    }
  }

  if packer_bootstrap then require('packer').sync() end
end)
