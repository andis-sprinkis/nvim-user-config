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
    sources = cmpc.sources(
      {
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        { name = 'latex_symbols' },
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'buffer' },
        { name = 'tmux' },
        { name = 'zsh' },
        { name = 'emoji' },
        { name = 'color_names'},
        { name = 'npm', keyword_length = 4 },
      }
    )
  })

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmpm.preset.cmdline(),
    sources = cmpc.sources(
      {
        { name = 'buffer' },
        { name = 'cmdline_history' },
      }
    ),
  })

  cmp.setup.cmdline({ ':', '@' }, {
    mapping = cmpm.preset.cmdline(),
    sources = cmpc.sources(
      {
        { name = 'cmdline_history' },
        { name = 'cmdline' },
        { name = 'path' },
        { name = 'buffer' },
        { name = 'zsh' },
        { name = 'tmux' },
        { name = 'emoji' },
      }
    ),
  })

  cmp.setup.filetype('gitcommit', {
    sources = cmpc.sources(
      {
        { name = 'cmp_git' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'zsh' },
        { name = 'tmux' },
        { name = 'emoji' },
      }
    ),
  })

  require("luasnip.loaders.from_vscode").lazy_load()
  require("cmp_git").setup()
end
