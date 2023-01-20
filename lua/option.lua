local g = vim.g
local o = vim.opt
local ol = vim.opt_local
local fn = vim.fn
local cmd = vim.cmd
local kms = vim.keymap.set
local api = vim.api
local env = vim.env
local cag = api.nvim_create_augroup
local cac = api.nvim_create_autocmd

if (fn.has('win64') == 1) then g.os = 'Windows'
else g.os = fn.substitute(fn.system('uname'), '\n', '', '') end

g.loaded_netrwPlugin = 0
g.man_hard_wrap = true
g.mapleader = ' '
o.backup = false
o.breakindent = true
o.clipboard = 'unnamedplus'
o.expandtab = true
o.foldlevel = 99
o.foldmethod = 'syntax'
o.hlsearch = false
o.list = true
o.listchars = { eol = '↲', tab = '» ' }
o.mouse = 'a'
o.number = true
o.pumblend = 10
o.relativenumber = true
o.scrolljump = -100
o.shiftwidth = 2
o.showmode = false
o.signcolumn = 'yes:2'
o.swapfile = false
o.tabstop = 2
o.termguicolors = true
o.title = true
o.titlelen = 1000
o.updatetime = 100
o.winblend = 10
o.writebackup = false

kms({ 'n', 'v' }, ';', ':')
kms({ 'n', 'v' }, 'h', '<bs>')
kms({ 'n', 'v' }, 'l', '<space>')
kms({ 'n' }, '<leader>v', cmd.split, { silent = true })
kms({ 'n' }, '<leader>o', cmd.vsplit, { silent = true })
kms({ 't' }, '<C-w>', '<C-\\><C-n>')

if g.os == 'Windows' then
  env.PATH = '%%ProgramFiles%%\\\\Git\\\\usr\\\\bin;' .. env.PATH
else
  env.LANG = 'en_US.UTF-8'
  env.PATH = fn.stdpath('config') .. '/bin:' .. env.PATH
end

local au_option = cag('option', {})

cac(
  { 'VimResized' },
  {
    group = au_option,
    callback = function() cmd.wincmd('=') end
  }
)
cac(
  { 'TermOpen' },
  {
    group = au_option,
    callback = function()
      ol.number = false
      ol.relativenumber = false
      ol.signcolumn = 'no'
    end
  }
)

cac(
  { 'TermOpen' },
  {
    group = au_option,
    pattern = { 'term://*' },
    callback = cmd.startinsert
  }
)

cac(
  { 'FileType' },
  {
    group = au_option,
    pattern = { 'help', 'man' },
    callback = function()
      ol.signcolumn = 'no'
    end
  }
)

cac(
  { 'FileType' },
  {
    group = au_option,
    pattern = { 'make' },
    callback = function()
      ol.expandtab = false
    end
  }
)

if g.neoray == 1 then
  o.guifont = 'CascadiaCodePL:h13'

  cmd([[
    NeoraySet KeyZoomIn <C-ScrollWheelUp>
    NeoraySet KeyZoomOut <C-ScrollWheelDown>
    NeoraySet WindowSize 108x40
    NeoraySet WindowState centered
  ]])
end
