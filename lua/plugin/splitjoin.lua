return function()
  vim.g.splitjoin_split_mapping = ''
  vim.g.splitjoin_join_mapping = ''
  vim.keymap.set({ 'n' }, '<Leader>k', ':SplitjoinJoin<cr>', { silent = true })
  vim.keymap.set({ 'n' }, '<Leader>j', ':SplitjoinSplit<cr>', { silent = true })
end
