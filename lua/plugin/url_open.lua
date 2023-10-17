local M = {
  'sontungexpt/url-open',
  event = 'VeryLazy',
  config = function()
    require("url-open").setup({
      deep_pattern = true,
      highlight_url = {
        all_urls = {
          enabled = false
        },
        cursor_move = {
          enabled = true,
          fg = 'text',
          bg = nil,
          underline = true
        }
      },
    })
    vim.keymap.set("n", "<Leader>l", "<esc>:URLOpenUnderCursor<cr>")
  end,
}

return M
