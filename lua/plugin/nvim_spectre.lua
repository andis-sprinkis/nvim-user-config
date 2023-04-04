return function()
  local spectre = require('spectre')
  local api = vim.api
  local km = vim.keymap.set

  local au_spectre = api.nvim_create_augroup('spectre', {})

  api.nvim_create_autocmd(
    { 'Filetype' },
    {
      group = au_spectre,
      pattern = 'spectre_panel',
      callback = function() vim.opt_local.signcolumn = 'no' end
    }
  )

  local map_opts = { nowait = true, silent = true }

  -- search global
  km('n', '<Leader>rr', spectre.open, map_opts)

  -- search current word
  km('n', '<Leader>rw', function() spectre.open_visual({ select_word = true }) end, map_opts)
  km('v', '<Leader>rw', spectre.open_visual, map_opts)

  -- search in current file
  km('n', '<Leader>rf', spectre.open_file_search, map_opts)
end
