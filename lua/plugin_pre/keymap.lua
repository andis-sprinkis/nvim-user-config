vim.g.mapleader = ' '

-- move over linebreak
vim.api.nvim_set_keymap('n', 'h', '<bs>', { noremap = true })
vim.api.nvim_set_keymap('n', 'l', '<space>', { noremap = true })
vim.api.nvim_set_keymap('v', 'h', '<bs>', { noremap = true })
vim.api.nvim_set_keymap('v', 'l', '<space>', { noremap = true })

-- creating splits
vim.api.nvim_set_keymap('n', '<leader>v', ':split<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>o', ':vsplit<cr>', { noremap = true, silent = true })

-- quit buffer
vim.api.nvim_set_keymap('n', '<esc>', ':q<cr>', { noremap = true, silent = true })

-- insert to normal mode in terminal
vim.api.nvim_set_keymap('t', '<C-w>', '<C-\\><C-n>', { noremap = true })
