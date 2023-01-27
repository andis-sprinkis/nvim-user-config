return function()
  local cmp = require("cmp")
  local cmpm = cmp.mapping
  local cmpc = cmp.config

  local luasnip = require("luasnip")

  local has_words_before = function()
    local api = vim.api
    local line, col = unpack(api.nvim_win_get_cursor(0))
    return col ~= 0 and api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local main_sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'zsh' },
    { name = 'tmux' },
    { name = 'emoji' },
    { name = 'npm', keyword_length = 4 }
  }

  cmp.setup({
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
      ["<S-Tab>"] = cmpm(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    sources = cmpc.sources(main_sources)
  })

  local gitcommit_sources = {
    { name = 'cmp_git' },
    { name = 'buffer' },
    { name = 'emoji' }
  }

  cmp.setup.filetype('gitcommit', { sources = cmpc.sources(gitcommit_sources) })

  local lookup_sources = {
    { name = 'cmdline_history' },
    { name = 'buffer' },
  }

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmpm.preset.cmdline(),
    sources = cmpc.sources(lookup_sources),
  })

  local cmd_sources = {
    { name = 'cmdline_history' },
    { name = 'cmdline' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'zsh' },
    { name = 'tmux' },
  }

  cmp.setup.cmdline(':', '@', {
    mapping = cmpm.preset.cmdline(),
    sources = cmpc.sources(cmd_sources),
  })

  require("luasnip.loaders.from_vscode").lazy_load()
  require("cmp_git").setup()
end
