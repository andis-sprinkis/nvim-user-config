local M = {
  'Wansmer/treesj',
  config = function()
    local km = vim.keymap.set
    local treesj = require('treesj')

    treesj.setup({
      use_default_keymaps = false,
      max_join_length = 2048,
    })

    local map_opts = { silent = true }
    km('n', '<Leader>k', treesj.join, map_opts)
    km('n', '<Leader>j', treesj.split, map_opts)
  end,
  event = 'VeryLazy'
}

return M
