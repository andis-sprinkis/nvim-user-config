local g = vim.g
local fn = vim.fn
local os = g.os
local executable = fn.executable

g.exec = {
  bash = executable('bash') == 1,
  bat = executable('bat') == 1,
  cat = executable('cat') == 1,
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
  dap_plugins = os ~= 'Windows_NT',
  fm_nvim = exec.lf,
  fzf_lua = os ~= 'Windows_NT',
  fzf_vim = os == 'Windows_NT' and exec.bash,
  lsp_plugins = exec.node,
  markdown_preview = exec.node,
  nvim_spectre = exec.sed,
  suda_vim = exec.sudo,
  swenv = exec.python3,
  vim_doge = exec.node
}

local sys_reqr = g.sys_reqr

local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
  {
    'chaoren/vim-wordmotion',
    'gpanders/editorconfig.nvim',
    'jghauser/mkdir.nvim',
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim',
    'tpope/vim-eunuch',
    'tpope/vim-fugitive',
    {
      'jvirtanen/vim-octave',
      ft = { 'octave' }
    },
    {
      'RRethy/vim-illuminate',
      dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'williamboman/mason.nvim',
      }
    },
    {
      'dhruvasagar/vim-table-mode',
      ft = { 'markdown', 'markdown.mdx' },
    },
    {
      'NvChad/nvim-colorizer.lua',
      config = require('plugin.nvim_colorizer'),
    },
    {
      'AckslD/swenv.nvim',
      config = require('plugin.swenv_nvim'),
      dependencies = 'stevearc/dressing.nvim',
    },
    {
      'tversteeg/registers.nvim',
      config = require('plugin.registers_nvim')
    },
    {
      'jghauser/follow-md-links.nvim',
      dependencies = 'nvim-treesitter/nvim-treesitter',
      ft = { 'markdown', 'markdown.mdx' },
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
      config = require('plugin.nvim_context_vt_nvim'),
      dependencies = 'nvim-treesitter/nvim-treesitter',
    },
    {
      'sindrets/winshift.nvim',
      config = require('plugin.winshift_nvim'),
    },
    {
      'lewis6991/gitsigns.nvim',
      config = require('plugin.gitsigns_nvim'),
      dependencies = {
        'tpope/vim-fugitive',
      },
    },
    {
      'nvim-treesitter/nvim-treesitter',
      dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
      },
      config = require('plugin.nvim_treesitter'),
      build = ':TSUpdate'
    },
    {
      'm-demare/hlargs.nvim',
      dependencies = { 'nvim-treesitter/nvim-treesitter' },
      config = require('plugin.hlargs_nvim'),
    },
    {
      'williamboman/mason.nvim',
      cond = sys_reqr.lsp_plugins,
      config = require('plugin.mason_nvim'),
      dependencies = {
        'b0o/schemastore.nvim',
        'jayp0521/mason-null-ls.nvim',
        'jose-elias-alvarez/null-ls.nvim',
        'neovim/nvim-lspconfig',
        'williamboman/mason-lspconfig.nvim',
        'lewis6991/gitsigns.nvim',
      }
    },
    {
      'mfussenegger/nvim-dap',
      cond = sys_reqr.dap_plugins,
      enable = sys_reqr.dap_plugins,
      config = require('plugin.nvim_dap')
    },
    {
      'ibhagwan/fzf-lua',
      cond = sys_reqr.fzf_lua,
      enable = sys_reqr.fzf_lua,
      config = require('plugin.fzf_lua')
    },
    {
      'junegunn/fzf.vim',
      cond = sys_reqr.fzf_vim,
      enabled = sys_reqr.fzf_vim,
      config = require('plugin.fzf_vim'),
      dependencies = {
        {
          'junegunn/fzf',
          build = './install --bin'
        }
      }
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
      dependencies = {
        'nvim-lua/plenary.nvim',
      }
    },
    {
      'lambdalisue/suda.vim',
      cond = sys_reqr.suda_vim,
      config = require('plugin.suda'),
    },
    {
      'kkoomen/vim-doge',
      cond = sys_reqr.vim_doge,
      build = function() fn['doge#install']() end,
      init = require('plugin.vim_doge_setup'),
    },
    {
      'iamcco/markdown-preview.nvim',
      cond = sys_reqr.markdown_preview,
      build = function() fn['mkdp#util#install']() end,
      ft = { 'markdown', 'markdown.mdx', 'lazy' },
    },
    {
      'AndrewRadev/splitjoin.vim',
      config = require('plugin.splitjoin_vim')
    },
    {
      'Mofiqul/vscode.nvim',
      config = require('plugin.colorscheme'),
      lazy = false,
      priority = 1000
    },
    {
      'NMAC427/guess-indent.nvim',
      config = require('plugin.guess_indent_nvim'),
      priority = 700
    },
    {
      'hrsh7th/nvim-cmp',
      config = require('plugin.nvim_cmp'),
      dependencies = {
        'David-Kunz/cmp-npm',
        'L3MON4D3/LuaSnip',
        'dmitmel/cmp-cmdline-history',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-emoji',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-path',
        'petertriho/cmp-git',
        'rafamadriz/friendly-snippets',
        'saadparwaiz1/cmp_luasnip',
        {
          'nat-418/cmp-color-names.nvim',
          config = require('plugin.cmp_color_names_nvim')
        },
        {
          'tamago324/cmp-zsh',
          cond = sys_reqr.cmp_zsh
        },
        {
          'andersevenrud/cmp-tmux',
          cond = sys_reqr.cmp_tmux
        },
      }
    },
    {
      'justinmk/vim-dirvish',
      config = require('plugin.dirvish'),
      priority = 900
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
      config = require('plugin.comment_nvim'),
      dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'JoosepAlviste/nvim-ts-context-commentstring',
      },
    },
    {
      "andrewferrier/debugprint.nvim",
      config = require('plugin.debugprint_nvim'),
    }
  },
  {
    ui = {
      icons = {
        cmd = "[cmd]",
        config = "[config]",
        event = "[event]",
        ft = "[ft]",
        init = "[init]",
        keys = "[keys]",
        plugin = "[plugin]",
        runtime = "[runtime]",
        source = "[source]",
        start = "[start]",
        task = "[task]",
        lazy = "💤 ",
      },
    },
    performance = {
      rtp = {
        disabled_plugins = {
          "gzip",
          "netrwPlugin",
          "rplugin",
          "spellfile",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    }
  }
)

require('statusline')
