local M = {
  'https://github.com/m-demare/hlargs.nvim',
  branch = 'main',
  commit = '05f3d1789642d5e1807121c05c42a5e883ba46d3',
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
