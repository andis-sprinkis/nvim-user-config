local M = {
  'nvim-pack/nvim-spectre',
  config = function()
    local spectre = require('spectre')
    local api = vim.api
    local km = vim.keymap.set

    local au_spectre = api.nvim_create_augroup('spectre', { clear = true })

    api.nvim_create_autocmd(
      { 'Filetype' },
      {
        group = au_spectre,
        pattern = 'spectre_panel',
        callback = function() vim.opt_local.signcolumn = 'no' end
      }
    )

    km(
      'n',
      '<Leader>rr',
      spectre.open,
      { nowait = true, silent = true, desc = 'Open Spectre (nvim-spectre)' }
    )

    km(
      'n',
      '<Leader>rw',
      function() spectre.open_visual({ select_word = true }) end,
      { nowait = true, silent = true, desc = 'Search current word (nvim-spectre)' }
    )

    km(
      'v',
      '<Leader>rw',
      spectre.open_visual,
      { nowait = true, silent = true, desc = 'Search selected word (nvim-spectre)' }
    )

    km(
      'n',
      '<Leader>rf',
      spectre.open_file_search,
      { nowait = true, silent = true, desc = 'Search in current file (nvim-spectre)' }
    )
  end,
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = 'Spectre',
  keys = { '<Leader>rr', '<Leader>rw', '<Leader>rf' }
}

return M
