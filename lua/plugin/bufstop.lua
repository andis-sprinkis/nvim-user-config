return function()
  local g = vim.g
  local km = vim.keymap.set

  g.BufstopSpeedKeys = { '<F1>', '<F2>', '<F3>', '<F4>', '<F5>', '<F6>' }
  g.BufstopLeader = ''
  g.BufstopAutoSpeedToggle = 1

  local map_opts = { silent = true, nowait = true }
  km('n', '<leader><leader>', ':BufstopModeFast<cr>2', map_opts)
  km('n', '<leader>b', ':BufstopFast<cr>', map_opts)
end