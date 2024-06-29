local M = {
  "zeioth/garbage-day.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    'williamboman/mason.nvim',
  },
  event = "VeryLazy",
  opts = {
    notifications = true
  }
}

return M
