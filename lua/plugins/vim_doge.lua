local g = vim.g
local sys_reqr = g.sys_reqr

local M = {
  'kkoomen/vim-doge',
  enabled = sys_reqr.vim_doge,
  build = function() vim.fn["doge#install"]() end,
  init = function()
    g.doge_enable_mappings = 0
  end,
  event = 'VeryLazy'
}

return M
