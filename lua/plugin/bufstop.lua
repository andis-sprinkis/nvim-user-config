return function()
  vim.g.BufstopSpeedKeys = { '<F1>', '<F2>', '<F3>', '<F4>', '<F5>', '<F6>' }
  vim.g.BufstopLeader = ''
  vim.g.BufstopAutoSpeedToggle = 1

  vim.keymap.set({ 'n' }, '<leader><leader>', ':BufstopModeFast<cr>2', { silent = true, nowait = true })
  vim.keymap.set({ 'n' }, '<leader>b', ':BufstopFast<cr>', { silent = true, nowait = true })
end
