local M = {
  'https://github.com/mrjones2014/smart-splits.nvim',
  init = function ()
    vim.g.smart_splits_multiplexer_integration = false
  end,
  config = function()
    local smart_splits = require('smart-splits')

    local km = vim.keymap.set

    km('n', '<C-A-h>', smart_splits.resize_left, { desc = 'Change window size to the left direction (smart-splits)' })
    km('n', '<C-A-j>', smart_splits.resize_down, { desc = 'Change window size to the down direction (smart-splits)' })
    km('n', '<C-A-k>', smart_splits.resize_up, { desc = 'Change window size to the up direction (smart-splits)' })
    km('n', '<C-A-l>', smart_splits.resize_right, { desc = 'Change window size to the right direction (smart-splits)' })
    km('n', '<leader>h', smart_splits.move_cursor_left,
      { desc = 'Move cursor to window left of current one (smart-splits)' })
    km('n', '<leader>j', smart_splits.move_cursor_down,
      { desc = 'Move cursor to window below current one (smart-splits)' })
    km('n', '<leader>k', smart_splits.move_cursor_up, { desc = 'Move cursor to window above current one (smart-splits)' })
    km('n', '<leader>l', smart_splits.move_cursor_right,
      { desc = 'Move cursor to window right of current one (smart-splits)' })
  end,
  keys = {
    { '<C-A-h>',   mode = 'n' },
    { '<C-A-j>',   mode = 'n' },
    { '<C-A-k>',   mode = 'n' },
    { '<C-A-l>',   mode = 'n' },
    { '<leader>h', mode = 'n' },
    { '<leader>j', mode = 'n' },
    { '<leader>k', mode = 'n' },
    { '<leader>l', mode = 'n' },
  }
}

return M
