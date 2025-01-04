local M = {
  'sindrets/winshift.nvim',
  config = function()
    require("winshift").setup({
      highlight_moving_win = true, -- Highlight the window being moved
      focused_hl_group = "Visual", -- The highlight group used for the moving window
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
  keys = { '<Leader>w' },
  cmd = { 'WinShift' }
}

return M
