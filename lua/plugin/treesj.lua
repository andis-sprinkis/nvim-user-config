local M = {
  'Wansmer/treesj',
  config = function()
    local km = vim.keymap.set
    local treesj = require('treesj')

    treesj.setup({
      use_default_keymaps = false,
      max_join_length = 2048,
      notify = false,
      cursor_behavior = 'start'
    })

    km('n', '<Leader>k', treesj.join, { silent = true, desc = 'Join node under cursor (treesj)' })
    km('n', '<Leader>j', treesj.split, { silent = true, desc = 'Split node under cursor (treesj)' })
  end,
  keys = { '<Leader>k', '<Leader>j' },
  dependencies = { 'nvim-treesitter/nvim-treesitter' }
}

return M
