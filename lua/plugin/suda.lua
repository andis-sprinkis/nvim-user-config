local g = vim.g
local sys_reqr = g.sys_reqr

local M = {
  'lambdalisue/suda.vim',
  cond = sys_reqr.suda_vim,
  enabled = sys_reqr.suda_vim,
  config = function()
    g.suda_smart_edit = 0
  end,
  cmd = { 'SudaRead', 'SudaWrite' }
}

return M
