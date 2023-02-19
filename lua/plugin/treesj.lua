return function()
  local kms = vim.keymap.set

  require('treesj').setup({
    use_default_keymaps = true,
    max_join_length = 2048,
  })

  local map_opts = { silent = true }
  kms('n', '<Leader>k', ':TSJJoin<cr>', map_opts)
  kms('n', '<Leader>j', ':TSJSplit<cr>', map_opts)
end
