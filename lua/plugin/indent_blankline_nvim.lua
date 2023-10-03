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
        highlight = { "Operator" },
      },
      exclude = {
        filetypes = {
          'help',
          'spectre_panel'
        },
      },
    })
  end,
  dependencies = {
    'NMAC427/guess-indent.nvim',
  }
}

return M
