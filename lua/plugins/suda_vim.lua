local g = vim.g

local M = {
  'https://github.com/lambdalisue/vim-suda',
  branch = 'master',
  commit = 'c492741b4679b3cdd4d9e34138209784e061d916',
  config = function()
    g.suda_smart_edit = 0
  end,
  cmd = { 'SudaRead', 'SudaWrite' }
}

return M
