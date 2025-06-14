local M = {
  'mrjones2014/smart-splits.nvim',
  config = function()
    local km = vim.keymap.set
    local smart_splits = require('smart-splits')

    smart_splits.setup({
      multiplexer_integration = false,
    })

    km('n', '<C-A-h>', smart_splits.resize_left, { desc = 'Change window size to the left direction (smart-splits)' })
    km('n', '<C-A-j>', smart_splits.resize_down, { desc = 'Change window size to the down direction (smart-splits)' })
    km('n', '<C-A-k>', smart_splits.resize_up, { desc = 'Change window size to the up direction (smart-splits)' })
    km('n', '<C-A-l>', smart_splits.resize_right, { desc = 'Change window size to the right direction (smart-splits)' })
    km('n', '<C-h>', smart_splits.move_cursor_left, { desc = 'Move cursor to window left of current one (smart-splits)' })
    km('n', '<C-j>', smart_splits.move_cursor_down, { desc = 'Move cursor to window below current one (smart-splits)' })
    km('n', '<C-k>', smart_splits.move_cursor_up, { desc = 'Move cursor to window above current one (smart-splits)' })
    km('n', '<C-l>', smart_splits.move_cursor_right,
      { desc = 'Move cursor to window right of current one (smart-splits)' })
  end,
  keys = {
    { '<C-A-h>', mode = 'n' },
    { '<C-A-j>', mode = 'n' },
    { '<C-A-k>', mode = 'n' },
    { '<C-A-l>', mode = 'n' },
    { '<C-h>',   mode = 'n' },
    { '<C-j>',   mode = 'n' },
    { '<C-k>',   mode = 'n' },
    { '<C-l>',   mode = 'n' },
  }
}

return M
