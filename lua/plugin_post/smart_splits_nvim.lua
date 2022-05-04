return function ()
  -- require('smart-splits').setup({
  --   -- Ignored filetypes (only while resizing)
  --   ignored_filetypes = {
  --     'nofile',
  --     'quickfix',
  --     'prompt',
  --   },
  --   -- Ignored buffer types (only while resizing)
  --   ignored_buftypes = { 'NvimTree' },
  --   -- when moving cursor between splits left or right,
  --   -- place the cursor on the same row of the *screen*
  --   -- regardless of line numbers. False by default.
  --   -- Can be overridden via function parameter, see Usage.
  --   move_cursor_same_row = false,
  -- })
  -- recommended mappings
  -- resizing splits
  vim.keymap.set('n', '<C-A-h>', require('smart-splits').resize_left)
  vim.keymap.set('n', '<C-A-j>', require('smart-splits').resize_down)
  vim.keymap.set('n', '<C-A-k>', require('smart-splits').resize_up)
  vim.keymap.set('n', '<C-A-l>', require('smart-splits').resize_right)
  -- moving between splits
  vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
  vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
  vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
  vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
end
