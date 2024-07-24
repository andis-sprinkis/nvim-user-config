local M = {
  'mihaifm/bufstop',
  init = function()
    local g = vim.g
    local km = vim.keymap.set

    g.BufstopSpeedKeys = { '<F1>', '<F2>', '<F3>', '<F4>', '<F5>', '<F6>' }
    g.BufstopLeader = ''
    g.BufstopAutoSpeedToggle = 1

    local map_opts = { silent = true, nowait = true }
    km('n', '<leader><leader>', ':BufstopModeFast<cr>2',
      { silent = true, nowait = true, desc = "Cycle the last 2 buffers (Bufstop)" })
    km('n', '<leader>b', function() vim.cmd('BufstopFast') end,
      { silent = true, nowait = true, desc = "View buffers list (Bufstop)" })
  end,
  event = 'VeryLazy'
}

return M
