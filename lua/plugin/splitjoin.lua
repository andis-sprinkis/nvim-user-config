return function()
  local g = vim.g
  local kms = vim.keymap.set
  g.splitjoin_split_mapping = ''
  g.splitjoin_join_mapping = ''
  kms('n', '<Leader>k', ':SplitjoinJoin<cr>', { silent = true })
  kms('n', '<Leader>j', ':SplitjoinSplit<cr>', { silent = true })
end
