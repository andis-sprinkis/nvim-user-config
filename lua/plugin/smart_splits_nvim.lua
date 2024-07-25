local M = {
  'mrjones2014/smart-splits.nvim',
  config = function()
    local km = vim.keymap.set
    local smart_splits = require('smart-splits')

    smart_splits.setup({
      multiplexer_integration = false,
    })

    -- resizing splits
    km('n', '<C-A-h>', smart_splits.resize_left, { desc = 'Dunno (smart-splits)' })
    km('n', '<C-A-j>', smart_splits.resize_down, { desc = 'Dunno (smart-splits)' })
    km('n', '<C-A-k>', smart_splits.resize_up, { desc = 'Dunno (smart-splits)' })
    km('n', '<C-A-l>', smart_splits.resize_right, { desc = 'Dunno (smart-splits)' })
    -- moving between splits
    km('n', '<C-h>', smart_splits.move_cursor_left, { desc = 'Dunno (smart-splits)' })
    km('n', '<C-j>', smart_splits.move_cursor_down, { desc = 'Dunno (smart-splits)' })
    km('n', '<C-k>', smart_splits.move_cursor_up, { desc = 'Dunno (smart-splits)' })
    km('n', '<C-l>', smart_splits.move_cursor_right, { desc = 'Dunno (smart-splits)' })
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
