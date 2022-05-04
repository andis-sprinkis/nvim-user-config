return function ()
  local cmp = require'cmp'
  local luasnip = require("luasnip")

  local main_sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'emoji' },
    { name = 'npm', keyword_length = 4 }
  }

  local gitcommit_sources = {
    { name = 'cmp_git' },
    { name = 'buffer' },
    { name = 'emoji' }
  }

  local cmdline_cmd_sources = {
    { name = 'cmdline' },
    { name = 'cmdline_history' },
    { name = 'path' },
    { name = 'buffer' },
  }

  local cmdline_lookup_sources = {
    { name = 'buffer' },
    { name = 'cmdline_history' },
  }

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
        elseif has_words_before() then cmp.complete()
        else fallback() end 
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then luasnip.jump(-1)
        else fallback() end
      end, { "i", "s" }),
    },
    sources = cmp.config.sources(main_sources)
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', { sources = cmp.config.sources(gitcommit_sources) })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', { sources = cmp.config.sources(cmdline_lookup_sources) })
  cmp.setup.cmdline('?', { sources = cmp.config.sources(cmdline_lookup_sources) })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', { sources = cmp.config.sources(cmdline_cmd_sources) })

  require("luasnip.loaders.from_vscode").load()
  require("cmp_git").setup()
end
