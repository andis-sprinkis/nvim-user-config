local M = {
  'sindrets/winshift.nvim',
  config = function()
    require("winshift").setup({
      highlight_moving_win = true,
      focused_hl_group = "Visual",
    })

    vim.keymap.set(
      'n',
      '<Leader>w',
      ':WinShift<cr>',
      {
        silent = true,
        desc = 'Enter window moving mode (winshift)',
      }
    )
  end,
  keys = {
    { '<Leader>w', mode = 'n' },
  },
  cmd = { 'WinShift' }
}

return M
