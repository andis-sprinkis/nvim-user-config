local M = {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  opts = {
    indent = { char = '│' },
    scope = { highlight = 'Normal' }
  },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  }
}

return M
