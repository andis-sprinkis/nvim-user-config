if vim.g.os == nil then
  if (vim.fn.has('win64') == 1) then vim.g.os = 'Windows'
  else vim.g.os = vim.fn.substitute(vim.fn.system('uname'), '\n', '', '') end
end

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.g.loaded_netrwPlugin = 0
vim.opt.backup = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.encoding = 'utf-8'
vim.opt.fcs = { eob = '' }
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'syntax'
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.list = true
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.signcolumn = 'yes:2'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.titlelen = 1000
vim.opt.updatetime = 100
vim.opt.wildmenu = true
vim.opt.wildmode = { 'longest:full', 'full' }
vim.opt.winblend = 10
vim.opt.writebackup = false
vim.opt.listchars = { eol = '↲', tab = '» ' }
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.breakindent = true
vim.g.man_hard_wrap = true

if vim.g.os == 'Windows' then
  vim.env.PATH = '%%ProgramFiles%%\\\\Git\\\\usr\\\\bin;' .. vim.env.PATH
else
  vim.env.LANG = 'en_US.UTF-8'
  vim.env.PATH = vim.fn.stdpath('config') .. '/bin:' .. vim.env.PATH
end

vim.cmd([[
  syntax on
  filetype plugin indent on

  au VimResized * wincmd =

  au TermOpen * setlocal nonumber norelativenumber signcolumn=no
  au TermOpen term://* startinsert

  au FileType help setlocal signcolumn=no
  au FileType man setlocal signcolumn=no
]])

if vim.g.neoray == 1 then
  vim.opt.guifont = 'CascadiaCodePL:h13'

  vim.cmd([[
    NeoraySet KeyZoomIn <C-ScrollWheelUp>
    NeoraySet KeyZoomOut <C-ScrollWheelDown>
    NeoraySet WindowSize 108x40
    NeoraySet WindowState centered
  ]])
end
