return function()
  local g = vim.g
  local kms = vim.keymap.set

  g.splitjoin_split_mapping = ''
  g.splitjoin_join_mapping = ''

  local map_opts = { silent = true }
  kms('n', '<Leader>k', ':SplitjoinJoin<cr>', map_opts)
  kms('n', '<Leader>j', ':SplitjoinSplit<cr>', map_opts)
end
