local M = {
  'https://github.com/m-demare/hlargs.nvim',
  config = function()
    require('hlargs').setup {
      hl_priority = 200,
      disable = function () return vim.b.largef end
    }
  end,
  event = 'VeryLazy',
  dependencies = { 'nvim-treesitter/nvim-treesitter' }
}

return M
