local M = {
  '2kabhishek/markit.nvim',
  config = function()
    require('markit').setup {
      builtin_marks = { ".", "<", ">", "^", "'" },
      sign_priority = {
        lower = 6,
        upper = 7,
        builtin = 5,
        bookmark = 4,
      },
      refresh_interval = 100,
      excluded_filetypes = { 'lazy', 'mason', 'dirvish', 'fugitive' },
    }

    vim.api.nvim_set_hl(0, 'MarkSignHL', { link = 'LineNr' })
    vim.api.nvim_set_hl(0, 'MarkSignNumHL', {})
  end,
  event = { 'BufReadPre', 'BufNewFile' },
}

return M
