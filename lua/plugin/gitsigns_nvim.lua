-- TODO: autocommand to detach from large buffers
local M = {
  'lewis6991/gitsigns.nvim',
  config = true,
  dependencies = {
    'tpope/vim-fugitive',
  },
  event = 'VeryLazy'
}

return M
