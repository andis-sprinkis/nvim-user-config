local g = vim.g
local fn = vim.fn
local cmd = vim.cmd
local os = g.os
local executable = fn.executable

g.exec = {
  bash = executable('bash') == 1,
  bat = executable('bat') == 1,
  cat = executable('cat') == 1,
  git = executable('git') == 1,
  go = executable('go') == 1,
  lf = executable('lf') == 1,
  node = executable('node') == 1,
  python3 = executable('python3') == 1,
  sed = executable('sed') == 1,
  sudo = executable('sudo') == 1,
  tmux = executable('tmux') == 1,
  zsh = executable('zsh') == 1,
}

local exec = g.exec

g.sys_reqr = {
  cmp_tmux = exec.tmux,
  cmp_zsh = exec.zsh,
  dap_plugins = os ~= 'Windows',
  fm_nvim = exec.lf,
  fzf = os == 'Windows' or os == 'Darwin',
  fzf_lua = os ~= 'Windows',
  fzf_vim = os == 'Windows' and exec.bash,
  git_plugins = exec.git,
  lsp_plugins = exec.node,
  markdown_preview = exec.node,
  nvim_spectre = exec.sed,
  suda_vim = exec.sudo,
  swenv = exec.python3,
  vim_doge = exec.node,
  vim_hexokinase = exec.go,
}

local sys_reqr = g.sys_reqr

local ensure_packer = function()
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    cmd([[packadd packer.nvim]])

    return true
  end

  return false
end

local packer_bootstrap = ensure_packer()

local packer = require('packer')

packer.startup(function(use)
  use {
    {
      'lewis6991/impatient.nvim',
      config = function() require('impatient') end,
    },
    'RRethy/vim-illuminate',
    'chaoren/vim-wordmotion',
    'dhruvasagar/vim-table-mode',
    'gpanders/editorconfig.nvim',
    'jghauser/mkdir.nvim',
    'markonm/traces.vim',
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim',
    'tpope/vim-eunuch',
    'wbthomason/packer.nvim',
    {
      'AckslD/swenv.nvim',
      requires = 'stevearc/dressing.nvim',
      config = require('plugin.swenv_nvim'),
    },
    { 'tversteeg/registers.nvim',
      config = require('plugin.registers_nvim')
    },
    {
      'jghauser/follow-md-links.nvim',
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
      after = 'nvim-treesitter',
      config = require('plugin.nvim_context_vt_nvim'),
    },
    {
      'sindrets/winshift.nvim',
      config = require('plugin.winshift_nvim'),
    },
    {
      'tpope/vim-fugitive',
      cond = sys_reqr.git_plugins,
      {
        'lewis6991/gitsigns.nvim',
        config = require('plugin.gitsigns_nvim'),
      },
    },
    {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = require('plugin.nvim_treesitter'),
      requires = {
        'JoosepAlviste/nvim-ts-context-commentstring',
        'nvim-treesitter/nvim-treesitter-textobjects',
      }
    },
    {
      'm-demare/hlargs.nvim',
      requires = { 'nvim-treesitter/nvim-treesitter' },
      config = require('plugin.hlargs_nvim'),
    },
    {
      'williamboman/mason.nvim',
      cond = sys_reqr.lsp_plugins,
      config = require('plugin.mason_nvim'),
      requires = {
        'b0o/schemastore.nvim',
        'jayp0521/mason-null-ls.nvim',
        'jose-elias-alvarez/null-ls.nvim',
        'neovim/nvim-lspconfig',
        'williamboman/mason-lspconfig.nvim',
      }
    },
    {
      'mfussenegger/nvim-dap',
      cond = sys_reqr.dap_plugins,
      config = require('plugin.nvim_dap')
    },
    {
      'junegunn/fzf',
      cond = sys_reqr.fzf,
      run = function() fn['fzf#install']() end,
    },
    {
      'ibhagwan/fzf-lua',
      cond = sys_reqr.fzf_lua,
      config = require('plugin.fzf_lua')
    },
    {
      'junegunn/fzf.vim',
      cond = sys_reqr.fzf_vim,
      config = require('plugin.fzf_vim')
    },
    {
      'is0n/fm-nvim',
      cond = sys_reqr.fm_nvim,
      config = require('plugin.fm_nvim')
    },
    {
      'nvim-pack/nvim-spectre',
      cond = sys_reqr.nvim_spectre,
      config = require('plugin.nvim_spectre'),
    },
    {
      'lambdalisue/suda.vim',
      cond = sys_reqr.suda_vim,
      config = require('plugin.suda'),
    },
    {
      'kkoomen/vim-doge',
      run = function() fn['doge#install']() end,
      setup = require('plugin.vim_doge_setup'),
      cond = sys_reqr.vim_doge,
    },
    {
      'rrethy/vim-hexokinase',
      run = 'make hexokinase',
      cond = sys_reqr.vim_hexokinase,
    },
    {
      'iamcco/markdown-preview.nvim',
      cond = sys_reqr.markdown_preview,
      run = function() fn['mkdp#util#install']() end,
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
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
        'dmitmel/cmp-cmdline-history',
        'saadparwaiz1/cmp_luasnip',
        'David-Kunz/cmp-npm',
        'petertriho/cmp-git',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-emoji',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        {
          'tamago324/cmp-zsh',
          cond = sys_reqr.cmp_zsh
        },
        {
          'andersevenrud/cmp-tmux',
          cond = sys_reqr.cmp_tmux
        },
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

  if packer_bootstrap then packer.sync() end

  require('statusline')
end)
