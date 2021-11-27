vim.cmd([[au FileType spectre_panel setlocal signcolumn=no]])

-- search global
vim.api.nvim_set_keymap('n', '<Leader>rr', ":lua require('spectre').open()<cr>", { noremap = true, nowait = true, silent = true })

-- search current word
vim.api.nvim_set_keymap('n', '<Leader>rw', ":lua require('spectre').open_visual({select_word=true})<cr>", { noremap = true, nowait = true, silent = true })
vim.api.nvim_set_keymap('v', '<Leader>rw', ":lua require('spectre').open_visual()<cr>", { noremap = true, nowait = true, silent = true })

-- search in current file
vim.api.nvim_set_keymap('n', '<Leader>rf', ":lua require('spectre').open_file_search()<cr>", { noremap = true, nowait = true, silent = true })
