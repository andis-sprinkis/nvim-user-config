return function()
  local kms = vim.keymap.set
  local smart_splits = require('smart-splits')

  -- resizing splits
  kms('n', '<C-A-h>', smart_splits.resize_left)
  kms('n', '<C-A-j>', smart_splits.resize_down)
  kms('n', '<C-A-k>', smart_splits.resize_up)
  kms('n', '<C-A-l>', smart_splits.resize_right)
  -- moving between splits
  kms('n', '<C-h>', smart_splits.move_cursor_left)
  kms('n', '<C-j>', smart_splits.move_cursor_down)
  kms('n', '<C-k>', smart_splits.move_cursor_up)
  kms('n', '<C-l>', smart_splits.move_cursor_right)
end
