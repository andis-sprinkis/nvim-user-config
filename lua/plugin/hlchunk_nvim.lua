local M = {
  'shellRaining/hlchunk.nvim',
  event = { "UIEnter" },
  config = function()
    require("hlchunk").setup({
      chunk = {
        notify = false
      },
      blank = {
        enable = false
      }
    })
  end
}

return M
