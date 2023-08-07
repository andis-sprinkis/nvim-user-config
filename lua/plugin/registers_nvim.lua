local M = {
  'tversteeg/registers.nvim',
  config = true,
  cmd = 'Registers',
  keys = {
    { "\"",    mode = { "n", "v" } },
    { "<C-R>", mode = "i" }
  },
}

return M
