return function()
  require("winshift").setup({
    highlight_moving_win = true, -- Highlight the window being moved
    focused_hl_group = "Visual", -- The highlight group used for the moving window
  })

  vim.api.nvim_set_keymap('n', '<Leader>w', ':WinShift<cr>', { silent = true })
end
