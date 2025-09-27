local g = vim.g

local M = {
  'https://github.com/lambdalisue/vim-suda',
  config = function()
    g.suda_smart_edit = 0
  end,
  cmd = { 'SudaRead', 'SudaWrite' }
}

return M
