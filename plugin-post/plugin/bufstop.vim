lua <<EOF
vim.g.BufstopSpeedKeys = { '<F1>', '<F2>', '<F3>', '<F4>', '<F5>', '<F6>' }
vim.g.BufstopLeader = ''
vim.g.BufstopAutoSpeedToggle = 1

vim.api.nvim_set_keymap('n', '<leader><leader>', ':BufstopModeFast<cr>2', { noremap = true, silent = true, nowait = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':BufstopFast<cr>', { noremap = true, silent = true, nowait = true })
EOF
