local g = vim.g
local fn = vim.fn
local sys_reqr = g.sys_reqr

local M = {
  'kkoomen/vim-doge',
  cond = sys_reqr.vim_doge,
  enabled = sys_reqr.vim_doge,
  build = function() fn['doge#install']() end,
  init = function()
    g.doge_enable_mappings = 0
  end,
  event = 'VeryLazy'
}

return M
