local M = {
  "https://github.com/zapling/mason-lock.nvim",
  init = function()
    require("mason-lock").setup()
  end,
  dependencies = {
    'https://github.com/mason-org/mason.nvim',
  }
}

return M
