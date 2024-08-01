local M = {
  'chomosuke/typst-preview.nvim',
  ft = 'typst',
  version = '0.3.*',
  build = function() require 'typst-preview'.update() end,
}

return M
