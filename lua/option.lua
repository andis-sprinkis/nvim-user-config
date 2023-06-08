local g = vim.g
local o = vim.opt
local ol = vim.opt_local
local fn = vim.fn
local cmd = vim.cmd
local km = vim.keymap.set
local api = vim.api
local env = vim.env
local ag = api.nvim_create_augroup
local ac = api.nvim_create_autocmd

g.os = vim.loop.os_uname().sysname
g.loaded_netrwPlugin = 0
g.man_hard_wrap = true
g.mapleader = ' '
o.backup = false
o.breakindent = true
o.clipboard = 'unnamedplus'
o.cursorline = true
o.expandtab = true
o.foldlevel = 99
o.foldmethod = 'indent'
o.hlsearch = false
o.list = true
o.listchars:append 'eol:↲'
o.listchars:append 'tab:» '
o.mouse = 'a'
o.number = true
o.pumblend = 10
o.relativenumber = true
o.scrolljump = -100
o.shiftwidth = 2
o.showmode = false
o.signcolumn = 'yes:2'
o.splitbelow = true
o.splitkeep = 'screen'
o.splitright = true
o.swapfile = false
o.tabstop = 2
o.termguicolors = true
o.title = true
o.titlelen = 1000
o.updatetime = 100
o.winblend = 10
o.writebackup = false

km({ 'n', 'v' }, ';', ':')
km({ 'n', 'v' }, 'h', '<bs>')
km({ 'n', 'v' }, 'l', '<space>')
km('n', '<leader>v', cmd.split)
km('n', '<leader>o', cmd.vsplit)
km('t', '<C-w>', '<C-\\><C-n>')

if g.os == 'Windows_NT' then
  env.PATH = '%%ProgramFiles%%\\\\Git\\\\usr\\\\bin;' .. env.PATH
else
  if not env.LANG then env.LANG = 'en_US.UTF-8' end
  env.PATH = fn.stdpath('config') .. '/bin:' .. env.PATH
end

local ag_option = ag('option', {})

ac(
  'VimResized',
  {
    group = ag_option,
    callback = function() cmd.wincmd('=') end
  }
)

ac(
  'TermOpen',
  {
    group = ag_option,
    callback = function()
      ol.number = false
      ol.relativenumber = false
      ol.signcolumn = 'no'
      cmd.startinsert()
    end
  }
)

ac(
  'FileType',
  {
    group = ag_option,
    pattern = { 'man', 'vimdoc' },
    callback = function()
      ol.number = true
      ol.relativenumber = true
    end
  }
)

ac(
  'FileType',
  {
    group = ag_option,
    pattern = { 'make' },
    callback = function()
      ol.expandtab = false
    end
  }
)

ac('TextYankPost', {
  pattern = '*',
  group = ag_option,
  callback = function() vim.highlight.on_yank { timeout = 170 } end,
})

if g.neoray == 1 then
  o.guifont = 'CascadiaCodePL:h13'

  cmd([[
    NeoraySet KeyZoomIn <C-ScrollWheelUp>
    NeoraySet KeyZoomOut <C-ScrollWheelDown>
    NeoraySet WindowSize 108x40
    NeoraySet WindowState centered
  ]])
end
