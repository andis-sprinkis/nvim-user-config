local M = {
  'https://github.com/m-demare/hlargs.nvim',
  branch = 'main',
  commit = '0b29317c944fb1f76503ce4540d6dceffbb5ccd2',
  config = function()
    require('hlargs').setup {
      hl_priority = 200,
      disable = function () return vim.b.largef end
    }
  end,
  event = 'VeryLazy',
  dependencies = { 'https://github.com/nvim-treesitter/nvim-treesitter' }
}

return M
