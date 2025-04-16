local M = {
  'lewis6991/gitsigns.nvim',
  config = function ()
    require('gitsigns').setup {
      sign_priority = 11
    }
  end,
  dependencies = {
    'tpope/vim-fugitive',
  },
  event = 'VeryLazy'
}

return M
