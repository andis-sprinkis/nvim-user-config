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

    km('n', '<C-k>', treesj.join, { silent = true, desc = 'Join node under cursor (treesj)' })
    km('n', '<C-j>', treesj.split, { silent = true, desc = 'Split node under cursor (treesj)' })
    km('n', '<Leader>m', treesj.toggle, { silent = true, desc = 'Toggle split or join node under cursor (treesj)' })
  end,
  keys = {
    { '<C-k>', mode = 'n' },
    { '<C-j>', mode = 'n' },
    { '<Leader>m', mode = 'n' },
  },
  dependencies = { 'nvim-treesitter/nvim-treesitter' }
}

return M
