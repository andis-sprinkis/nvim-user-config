lua <<EOF
vim.g.splitjoin_split_mapping = ''
vim.g.splitjoin_join_mapping = ''
vim.api.nvim_set_keymap('n', '<Leader>k', ':SplitjoinJoin<cr>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>j', ':SplitjoinSplit<cr>', { silent = true })
EOF
