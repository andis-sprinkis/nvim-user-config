vim.g.mapleader = ' '

-- move over linebreak
vim.keymap.set({ 'n', 'v' }, 'h', '<bs>')
vim.keymap.set({ 'n', 'v' }, 'l', '<space>')

-- creating splits
vim.keymap.set({ 'n' }, '<leader>v', vim.cmd.split, { silent = true })
vim.keymap.set({ 'n' }, '<leader>o', vim.cmd.vsplit, { silent = true })

-- insert to normal mode in terminal
vim.keymap.set({ 't' }, '<C-w>', '<C-\\><C-n>')
