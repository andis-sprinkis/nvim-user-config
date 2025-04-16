local M = {
  '2kabhishek/markit.nvim',
  config = function()
    require('markit').setup {
      builtin_marks = { ".", "<", ">", "^", "'" },
      sign_priority = {
        lower=6,
        upper=7,
        builtin=5,
        bookmark=4,
      }
    }

    vim.api.nvim_set_hl(0, 'MarkSignHL', { link = 'Normal' })
  end,
  excluded_filetypes = { 'lazy', 'mason', 'dirvish' },
  event = { 'BufReadPre', 'BufNewFile' },
}

return M
