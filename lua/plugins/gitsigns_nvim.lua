local M = {
  'https://github.com/lewis6991/gitsigns.nvim',
  config = function ()
    require('gitsigns').setup {
      sign_priority = 11
    }
  end,
  event = 'VeryLazy'
}

return M
