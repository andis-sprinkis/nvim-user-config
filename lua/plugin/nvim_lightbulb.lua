local M = {
  'kosayoda/nvim-lightbulb',
  config = function()
    require("nvim-lightbulb").setup({
      autocmd = { enabled = true },
      ignore = {
        clients = { "null-ls" },
      }
    })
  end
}

return M
