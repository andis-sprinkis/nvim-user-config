local g = vim.g
local sys_reqr = g.sys_reqr

local M = {
  'hrsh7th/nvim-cmp',
  config = function()
    local cmp = require("cmp")
    local cmpm = cmp.mapping
    local cmpc = cmp.config
    local api = vim.api

    require("cmp_dictionary").setup({
      exact_length = 2, -- exact_length must match cmp sources entry keyword_length
      first_case_insensitive = true,
      document = {
        enable = false,
        command = { "wn", "${label}", "-over" },
      },
      max_number_items = 3000,
      debug = false,
      paths = {
        "~/.local/share/dict/aspell_en/aspell_en.dict",
        "~/.local/share/dict/aspell_lv/aspell_lv_no_conjugations.dict",
      }
    })

    local luasnip = require("luasnip")

    local source_cmp_rg = {
      name = 'rg',
      keyword_length = 3,
      debounce = 200,
    }

    local source_cmp_dictionary = {
      name = "dictionary",
      keyword_length = 2,
    }

    local source_cmp_buffer = {
      name = 'buffer',
      option = {
        get_bufnrs = function()
          if vim.b.large_file_buf then return {} end
          return { buf = vim.api.nvim_get_current_buf() }
        end
      }
    }

    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      view = {
        entries = {
          selection_order = 'near_cursor',
        }
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-l>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.abort()
          else
            cmp.complete()
          end
        end),
        ['<Esc>'] = cmp.mapping(function(fallback)
          -- conditional needed to not break [digit]o/O
          if cmp.visible() then
            cmp.abort()
            vim.defer_fn(function() vim.cmd('stopinsert') end, 0)
          else
            fallback()
          end
        end),
        ['<CR>'] = cmp.mapping.confirm({ select = true })
      }),
      experimental = {
        ghost_text = { hl_group = 'Whitespace' }
      },
      sources = cmpc.sources(
        {
          { name = 'copilot' },
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'latex_symbols' },
          { name = 'nvim_lua' },
          { name = 'path' },
          source_cmp_buffer,
          { name = 'tmux' },
          { name = 'zsh' },
          source_cmp_rg,
          source_cmp_dictionary,
          { name = 'emoji' },
          { name = 'color_names' },
          {
            name = 'npm',
            keyword_length = 3,
          },
        }
      )
    })

    cmp.setup.cmdline(
      { '/', '?' },
      {
        mapping = cmpm.preset.cmdline(),
        sources = cmpc.sources(
          {
            source_cmp_buffer,
            { name = 'cmdline_history' },
          }
        ),
      }
    )

    cmp.setup.cmdline({ ':', '@' }, {
      mapping = cmpm.preset.cmdline(),
      sources = cmpc.sources(
        {
          { name = 'cmdline' },
          { name = 'cmdline_history' },
          {
            name = 'path',
            keyword_length = 2,
          },
          source_cmp_buffer,
          {
            name = 'nvim_lsp',
            keyword_length = 2,
          },
          source_cmp_rg,
          { name = 'zsh' },
          { name = 'tmux' },
          source_cmp_dictionary,
          { name = 'emoji' },
        }
      ),
    })

    cmp.setup.filetype('gitcommit', {
      sources = cmpc.sources(
        {
          { name = 'cmp_git' },
          { name = 'buffer' },
          { name = 'nvim_lsp' },
          source_cmp_rg,
          { name = 'path' },
          { name = 'zsh' },
          { name = 'tmux' },
          source_cmp_dictionary,
          { name = 'emoji' },
        }
      ),
    })

    cmp.setup.filetype(
      { "dap-repl", "dapui_watches", "dapui_hover" },
      {
        sources = cmpc.sources({
          { name = "dap" },
          { name = 'path' },
          { name = 'zsh' },
          { name = 'tmux' },
        }),
      }
    )

    luasnip.filetype_extend('all', { 'loremipsum' })

    require("luasnip.loaders.from_vscode").lazy_load()
    require("cmp_git").setup()
  end,
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
    'petertriho/cmp-git',
    'rafamadriz/friendly-snippets',
    'saadparwaiz1/cmp_luasnip',
    'uga-rosa/cmp-dictionary',
    {
      'lukas-reineke/cmp-rg',
      cond = sys_reqr.cmp_rg,
      enabled = sys_reqr.cmp_rg,
    },
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
    -- {
    --   "zbirenbaum/copilot-cmp",
    --   config = function()
    --     require("copilot_cmp").setup()
    --   end,
    --   dependencies = {
    --     {
    --       "zbirenbaum/copilot.lua",
    --       config = function()
    --         require("copilot").setup({
    --           suggestion = { enabled = false },
    --           panel = { enabled = false },
    --         })
    --       end
    --     }
    --   }
    -- }
  },
  event = { "InsertEnter", "CmdlineEnter" },
}

return M
