local sys_reqr = vim.g.sys_reqr

local M = {
  'chomosuke/typst-preview.nvim',
  ft = 'typst',
  version = '1.*',
  enabled = sys_reqr.typst_preview_nvim,
  build = function() require 'typst-preview'.update() end,
  config = function()
    require 'typst-preview'.setup {
      invert_colors = 'auto'
    }
  end,
}

return M
