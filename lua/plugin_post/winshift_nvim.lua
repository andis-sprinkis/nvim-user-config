return function()
  require("winshift").setup({
    highlight_moving_win = true, -- Highlight the window being moved
    focused_hl_group = "Visual", -- The highlight group used for the moving window
    -- The window picker is used to select a window while swapping windows with
    -- ':WinShift swap'.
    -- A string of chars used as identifiers by the window picker.
    window_picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
    window_picker_ignore = {
      -- This table allows you to indicate to the window picker that a window
      -- should be ignored if its buffer matches any of the following criteria.
      filetype = { -- List of ignored file types
        "NvimTree",
      },
      buftype = { -- List of ignored buftypes
        "terminal",
        "quickfix",
      },
    },
  })

  vim.api.nvim_set_keymap('n', '<Leader>w', ':WinShift<cr>', { silent = true })
end
