local M = {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  config = function()
    require('ibl').setup({
      indent = {
        char = { '▏' },
      },
      scope = {
        char = { '▏' },
        highlight = { "Function", "Label" },
      },
      exclude = {
        filetypes = {
          'help',
          'spectre_panel'
        },
      },
    })

    local hooks = require "ibl.hooks"
    hooks.register(
      hooks.type.ACTIVE,
      function()
        return not vim.b.large_file_buf
      end
    )
  end,
  dependencies = {
    'NMAC427/guess-indent.nvim',
  }
}

return M
