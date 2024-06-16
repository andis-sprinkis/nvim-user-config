local M = {
  'm-demare/hlargs.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('hlargs').setup {
      hl_priority = 200,
    }
  end,
  event = 'VeryLazy'
}

return M
