vim.g.mapleader = ' '

-- move over linebreak
vim.api.nvim_set_keymap('n', 'h', '<bs>', { noremap = true })
vim.api.nvim_set_keymap('n', 'l', '<space>', { noremap = true })
vim.api.nvim_set_keymap('v', 'h', '<bs>', { noremap = true })
vim.api.nvim_set_keymap('v', 'l', '<space>', { noremap = true })

-- resize splits
vim.api.nvim_set_keymap('n', '<C-A-j>', ':resize +2<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-A-k>', ':resize -2<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-A-l>', ':vertical resize +4<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-A-h>', ':vertical resize -4<cr>', { noremap = true, silent = true })

-- quicker split switching
vim.api.nvim_set_keymap('n', '<C-j>', '<C-W><C-J>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-W><C-K>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-W><C-L>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-W><C-H>', { noremap = true })

-- creating splits
vim.api.nvim_set_keymap('n', '<leader>s', ':split<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>vs', ':vsplit<cr>', { noremap = true, silent = true })

-- insert to normal mode in terminal
vim.api.nvim_set_keymap('t', '<C-w>', '<C-\\><C-n>', { noremap = true })
