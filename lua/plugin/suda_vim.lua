local g = vim.g

local M = {
  'lambdalisue/suda.vim',
  config = function()
    g.suda_smart_edit = 0
  end,
  cmd = { 'SudaRead', 'SudaWrite' }
}

return M
