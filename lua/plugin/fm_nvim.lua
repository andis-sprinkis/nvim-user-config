local sys_reqr = vim.g.sys_reqr

local M = {
  'is0n/fm-nvim',
  cond = sys_reqr.fm_nvim,
  enabled = sys_reqr.fm_nvim,
  config = function()
    require('fm-nvim').setup {
      ui = {
        float = {
          border = "rounded",
          blend = 10,
          height = 0.9375,
          width = 0.9375,
          y = 0.25,
        }
      }
    }
  end,
  cmd = 'Lf'
}

return M
