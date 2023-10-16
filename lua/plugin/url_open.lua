local M = {
  'sontungexpt/url-open',
  config = function()
    require("url-open").setup({})
    vim.keymap.set("n", "<cr>", "<esc>:URLOpenUnderCursor<cr>")
  end }

return M
