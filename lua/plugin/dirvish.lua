local M = {
  'justinmk/vim-dirvish',
  config = function()
    vim.g.dirvish_mode = ':sort ,^.*[\\/],'
  end,
  lazy = false,
  priority = 900
}

return M
