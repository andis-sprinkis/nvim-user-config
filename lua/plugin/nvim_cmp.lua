return function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local main_sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'zsh' },
    { name = 'tmux' },
    { name = 'emoji' },
    { name = 'npm', keyword_length = 4 },
    { name = 'cmdline' },
    { name = 'cmdline_history' },
  }

  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
      ['<Tab>'] = cmp.mapping(function(fallback)
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
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    sources = cmp.config.sources(main_sources)
  })

  -- Set configuration for specific filetype.
  local gitcommit_sources = {
    { name = 'cmp_git' },
    { name = 'buffer' },
    { name = 'emoji' }
  }

  cmp.setup.filetype('gitcommit', { sources = cmp.config.sources(gitcommit_sources) })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  local cmdline_lookup_sources = {
    { name = 'buffer' },
    { name = 'cmdline_history' },
  }

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(cmdline_lookup_sources),
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  local cmdline_cmd_sources = {
    { name = 'cmdline' },
    { name = 'cmdline_history' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'zsh' },
    { name = 'tmux' },
  }

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(cmdline_cmd_sources),
  })

  require("luasnip.loaders.from_vscode").load()
  require("cmp_git").setup()
end
