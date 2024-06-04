local g = vim.g
local sys_reqr = g.sys_reqr

local M = {
  'hrsh7th/nvim-cmp',
  config = function()
    local cmp = require("cmp")
    local cmpm = cmp.mapping
    local cmpc = cmp.config
    local api = vim.api

    local luasnip = require("luasnip")

    local has_words_before = function()
      local line, col = unpack(api.nvim_win_get_cursor(0))
      return col ~= 0 and api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local source_cmp_rg = {
      name = 'rg',
      keyword_length = 3,
      debounce = 200,
    }

    local source_cmp_dictionary = {
      name = "dictionary",
      keyword_length = 3,
    }

    cmp.setup({
      enabled = function()
        return api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
      end,
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      mapping = {
        ['<C-b>'] = cmpm.scroll_docs(-4),
        ['<C-f>'] = cmpm.scroll_docs(4),
        ['<C-Space>'] = cmpm.complete(),
        ['<C-e>'] = cmpm.abort(),
        ['<CR>'] = cmpm.confirm({ select = false }),
        ['<Tab>'] = cmpm(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ['<S-Tab>'] = cmpm(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      sources = cmpc.sources(
        {
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'latex_symbols' },
          { name = 'nvim_lua' },
          { name = 'path' },
          { name = 'buffer' },
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
        view = {
          entries = { name = 'custom', selection_order = 'near_cursor' }
        },
        sources = cmpc.sources(
          {
            { name = 'buffer' },
            { name = 'cmdline_history' },
          }
        ),
      }
    )

    cmp.setup.cmdline({ ':', '@' }, {
      mapping = cmpm.preset.cmdline(),
      view = {
        entries = { name = 'custom', selection_order = 'near_cursor' }
      },
      sources = cmpc.sources(
        {
          { name = 'cmdline' },
          { name = 'cmdline_history' },
          {
            name = 'path',
            keyword_length = 2,
          },
          {
            name = 'buffer',
            keyword_length = 2,
          },
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
    require('plugin.cmp_dictionary'),
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
}

return M
