return function()
  local spectre = require('spectre')

  vim.cmd([[au FileType spectre_panel setlocal signcolumn=no]])

  local map_opts = { nowait = true, silent = true }

  -- search global
  vim.keymap.set({ 'n' }, '<Leader>rr', spectre.open, map_opts)

  -- search current word
  vim.keymap.set({ 'n' }, '<Leader>rw', function() spectre.open_visual({ select_word = true }) end, map_opts)
  vim.keymap.set({ 'v' }, '<Leader>rw', spectre.open_visual, map_opts)

  -- search in current file
  vim.keymap.set({ 'n' }, '<Leader>rf', spectre.open_file_search, map_opts)
end
