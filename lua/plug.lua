local g = vim.g
local fn = vim.fn
local os = g.os
local executable = fn.executable

local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  if fn.confirm("Download and initialize the configured plugins?", "&Yes\n&No", 2) == 2 then return end
  fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

g.exec = {
  bash = executable('bash') == 1,
  bat = executable('bat') == 1,
  cat = executable('cat') == 1,
  fzf = executable('fzf') == 1,
  lf = executable('lf') == 1,
  node = executable('node') == 1,
  python3 = executable('python3') == 1,
  rg = executable('rg') == 1,
  sed = executable('sed') == 1,
  sudo = executable('sudo') == 1,
  tmux = executable('tmux') == 1,
  zsh = executable('zsh') == 1,
}

local exec = g.exec

g.sys_reqr = {
  cmp_tmux = exec.tmux,
  cmp_zsh = exec.zsh,
  cmp_rg = exec.rg,
  fm_nvim = exec.lf,
  fzf_lua = os ~= 'Windows_NT' and exec.fzf,
  fzf_vim = os == 'Windows_NT' and exec.bash,
  lsp_plugins = exec.node,
  markdown_preview = exec.node,
  nvim_spectre = exec.sed,
  suda_vim = exec.sudo,
  swenv = exec.python3,
  vim_doge = exec.node,
}

local sys_reqr = g.sys_reqr

require("lazy").setup(
  {
    {
      'chaoren/vim-wordmotion',
      event = 'VeryLazy'
    },
    'stevearc/dressing.nvim',
    'tpope/vim-fugitive',
    {
      'jghauser/mkdir.nvim',
      event = 'VeryLazy'
    },
    {
      'tpope/vim-eunuch',
      event = 'VeryLazy'
    },
    {
      'jvirtanen/vim-octave',
      ft = { 'octave' }
    },
    {
      'HiPhish/rainbow-delimiters.nvim',
      event = 'VeryLazy'
    },
    {
      'dhruvasagar/vim-table-mode',
      ft = { 'markdown', 'markdown.mdx' },
    },
    {
      'yorickpeterse/nvim-pqf',
      config = true,
      event = 'VeryLazy',
    },
    {
      'chrisgrieser/nvim-early-retirement',
      config = true,
      event = 'BufHidden'
    },
    {
      'NvChad/nvim-colorizer.lua',
      config = require('plugin.nvim_colorizer'),
    },
    {
      'AckslD/swenv.nvim',
      config = require('plugin.swenv_nvim'),
      dependencies = {
        'stevearc/dressing.nvim',
        'williamboman/mason.nvim',
      },
      event = 'VeryLazy'
    },
    {
      'tversteeg/registers.nvim',
      config = true,
      cmd = 'Registers',
      keys = {
        { "\"",    mode = { "n", "v" } },
        { "<C-R>", mode = "i" }
      },
    },
    {
      'jghauser/follow-md-links.nvim',
      dependencies = { 'nvim-treesitter/nvim-treesitter' },
      ft = { 'markdown', 'markdown.mdx' },
    },
    {
      'mrjones2014/smart-splits.nvim',
      config = require('plugin.smart_splits_nvim'),
      event = 'VeryLazy'
    },
    {
      'haringsrob/nvim_context_vt',
      config = require('plugin.nvim_context_vt_nvim'),
      dependencies = { 'nvim-treesitter/nvim-treesitter' },
      event = 'VeryLazy'
    },
    {
      'sindrets/winshift.nvim',
      config = require('plugin.winshift_nvim'),
      event = 'VeryLazy'
    },
    {
      'lewis6991/gitsigns.nvim',
      config = true,
      dependencies = {
        'tpope/vim-fugitive',
      },
      event = 'VeryLazy'
    },
    {
      'nvim-treesitter/nvim-treesitter',
      config = require('plugin.nvim_treesitter'),
      build = ':TSUpdate'
    },
    {
      'm-demare/hlargs.nvim',
      dependencies = { 'nvim-treesitter/nvim-treesitter' },
      config = true,
      event = 'VeryLazy'
    },
    {
      'williamboman/mason.nvim',
      cond = sys_reqr.lsp_plugins,
      enabled = sys_reqr.lsp_plugins,
      config = require('plugin.mason_nvim'),
      dependencies = {
        'b0o/schemastore.nvim',
        'jay-babu/mason-nvim-dap.nvim',
        'jayp0521/mason-null-ls.nvim',
        'jose-elias-alvarez/null-ls.nvim',
        'lewis6991/gitsigns.nvim',
        'neovim/nvim-lspconfig',
        'williamboman/mason-lspconfig.nvim',
        'mfussenegger/nvim-dap',
        {
          'theHamsta/nvim-dap-virtual-text',
          config = require('plugin.nvim_dap_virtual_text'),
          dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-treesitter/nvim-treesitter',
          },
        },
        {
          'rcarriga/nvim-dap-ui',
          config = require('plugin.nvim_dap_ui'),
          dependencies = {
            'mfussenegger/nvim-dap',
          },
        },
        {
          'RRethy/vim-illuminate',
          dependencies = { 'nvim-treesitter/nvim-treesitter' },
        },
      }
    },
    {
      'ibhagwan/fzf-lua',
      cond = sys_reqr.fzf_lua,
      enabled = sys_reqr.fzf_lua,
      config = require('plugin.fzf_lua'),
      event = 'VeryLazy'
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
      },
      event = 'VeryLazy'
    },
    {
      'is0n/fm-nvim',
      cond = sys_reqr.fm_nvim,
      enabled = sys_reqr.fm_nvim,
      config = require('plugin.fm_nvim'),
      cmd = 'Lf'
    },
    {
      'nvim-pack/nvim-spectre',
      cond = sys_reqr.nvim_spectre,
      enabled = sys_reqr.nvim_spectre,
      config = require('plugin.nvim_spectre'),
      dependencies = { 'nvim-lua/plenary.nvim' },
      event = 'VeryLazy'
    },
    {
      'lambdalisue/suda.vim',
      cond = sys_reqr.suda_vim,
      enabled = sys_reqr.suda_vim,
      config = require('plugin.suda'),
      event = 'VeryLazy'
    },
    {
      'kkoomen/vim-doge',
      cond = sys_reqr.vim_doge,
      enabled = sys_reqr.vim_doge,
      build = function() fn['doge#install']() end,
      init = require('plugin.vim_doge_setup'),
      event = 'VeryLazy'
    },
    {
      'iamcco/markdown-preview.nvim',
      cond = sys_reqr.markdown_preview,
      enabled = sys_reqr.markdown_preview,
      build = function() fn['mkdp#util#install']() end,
      ft = { 'markdown', 'markdown.mdx' },
      cmd = { 'MarkdownPreview', 'MarkdownPreviewToggle' }
    },
    {
      'Wansmer/treesj',
      dependencies = { 'nvim-treesitter/nvim-treesitter' },
      config = require('plugin.treesj'),
      event = 'VeryLazy'
    },
    {
      'Mofiqul/vscode.nvim',
      config = require('plugin.colorscheme'),
      lazy = false,
      priority = 1000
    },
    {
      'NMAC427/guess-indent.nvim',
      config = true,
      lazy = false,
      priority = 900
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
        'kdheepak/cmp-latex-symbols',
        {
          'rcarriga/cmp-dap',
          dependencies = {
            'mfussenegger/nvim-dap',
          }
        },
        {
          'lukas-reineke/cmp-rg',
          cond = sys_reqr.cmp_rg,
          enabled = sys_reqr.cmp_rg,
        },
        'petertriho/cmp-git',
        'rafamadriz/friendly-snippets',
        'saadparwaiz1/cmp_luasnip',
        {
          'nat-418/cmp-color-names.nvim',
          config = true
        },
        {
          'tamago324/cmp-zsh',
          cond = sys_reqr.cmp_zsh,
          enabled = sys_reqr.cmp_zsh
        },
        {
          'andersevenrud/cmp-tmux',
          cond = sys_reqr.cmp_tmux,
          enabled = sys_reqr.cmp_tmux
        },
      },
      event = { "InsertEnter", "CmdlineEnter" },
    },
    {
      'justinmk/vim-dirvish',
      config = require('plugin.dirvish'),
      lazy = false,
      priority = 900
    },
    {
      'lukas-reineke/indent-blankline.nvim',
      config = require('plugin.indent_blankline_nvim'),
      dependencies = {
        'NMAC427/guess-indent.nvim',
      }
    },
    {
      'mihaifm/bufstop',
      init = require('plugin.bufstop'),
      event = 'VeryLazy'
    },
    {
      'numToStr/Comment.nvim',
      config = require('plugin.comment_nvim'),
      dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'JoosepAlviste/nvim-ts-context-commentstring',
      },
      event = 'VeryLazy'
    },
    {
      "andrewferrier/debugprint.nvim",
      config = true,
      event = 'VeryLazy'
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
