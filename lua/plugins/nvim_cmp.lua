local g = vim.g
local sys_reqr = g.sys_reqr

local M = {
  'https://github.com/hrsh7th/nvim-cmp',
  config = function()
    local cmp = require("cmp")
    local cmpm = cmp.mapping
    local cmpc = cmp.config

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
          if vim.b.largef then return {} end
          return { buf = vim.api.nvim_get_current_buf() }
        end
      }
    }

    cmp.setup({
      formatting = {
        format = function(entry, vim_item)
          vim_item.menu = entry.source.name

          return vim_item
        end,
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
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
        ['<C-l>'] = cmp.mapping(function()
          if cmp.visible() then
            cmp.abort()
          else
            cmp.complete()
          end
        end),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ['<Esc>'] = cmp.mapping({
          i = function(fallback)
            -- conditional needed to not break [digit]o/O
            if cmp.visible() then
              cmp.abort()
              vim.defer_fn(function() vim.cmd('stopinsert') end, 0)
            else
              fallback()
            end
          end,
          s = function(fallback)
            if cmp.visible() then
              cmp.abort()
            else
              fallback()
            end
          end,
          c = function()
            if cmp.visible() then
              cmp.abort()
            else
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-c>', true, true, true), 'n', true)
            end
          end
        }),
        ["<CR>"] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
              fallback()
            end
          end,
          s = cmp.mapping.confirm({ select = false }),
          -- c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
        }),
      }),
      experimental = {
        ghost_text = { hl_group = 'Whitespace' }
      },
      sources = cmpc.sources(
        {
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'path' },
          source_cmp_buffer,
          { name = 'tmux' },
          source_cmp_rg,
          source_cmp_dictionary,
          { name = 'emoji' },
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
          {
            name = 'cmdline',
            ignore_cmds = { 'Man', '!', 'Lf' }
          },
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
          { name = 'tmux' },
          source_cmp_dictionary,
          { name = 'emoji' },
        }
      ),
    })
  end,
  dependencies = {
    {
      'https://github.com/saadparwaiz1/cmp_luasnip',
      config = function()
        require("luasnip").filetype_extend('all', { 'loremipsum' })
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
      dependencies = {
        {
          'https://github.com/L3MON4D3/LuaSnip',
          dependencies = { 'https://github.com/rafamadriz/friendly-snippets' }
        },
      }
    },
    'https://github.com/dmitmel/cmp-cmdline-history',
    'https://github.com/hrsh7th/cmp-buffer',
    'https://github.com/hrsh7th/cmp-cmdline',
    'https://github.com/hrsh7th/cmp-emoji',
    'https://github.com/hrsh7th/cmp-nvim-lsp',
    'https://github.com/hrsh7th/cmp-path',
    'https://github.com/uga-rosa/cmp-dictionary',
    {
      'https://github.com/lukas-reineke/cmp-rg',
      enabled = sys_reqr.cmp_rg,
    },
    {
      'https://github.com/andersevenrud/cmp-tmux',
      enabled = sys_reqr.cmp_tmux
    },
  },
  event = { "InsertEnter", "CmdlineEnter" },
}

return M
