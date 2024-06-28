local M = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = { char = "│" },
  },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  }
}

return M
