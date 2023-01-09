return function()
  local smart_splits = require('smart-splits')

  -- resizing splits
  vim.keymap.set('n', '<C-A-h>', smart_splits.resize_left)
  vim.keymap.set('n', '<C-A-j>', smart_splits.resize_down)
  vim.keymap.set('n', '<C-A-k>', smart_splits.resize_up)
  vim.keymap.set('n', '<C-A-l>', smart_splits.resize_right)
  -- moving between splits
  vim.keymap.set('n', '<C-h>', smart_splits.move_cursor_left)
  vim.keymap.set('n', '<C-j>', smart_splits.move_cursor_down)
  vim.keymap.set('n', '<C-k>', smart_splits.move_cursor_up)
  vim.keymap.set('n', '<C-l>', smart_splits.move_cursor_right)
end
