vim.cmd([[
syntax on
filetype plugin indent on
]])

vim.g.loaded_netrw = 0
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
vim.opt.wildmode = { 'longest:list', 'full' }
vim.opt.winblend = 10
vim.opt.writebackup = false
vim.opt.listchars = { eol = '¶', tab = '» ' }

if vim.g.os == 'Windows' then
  vim.env.PATH = '%%ProgramFiles%%\\\\Git\\\\usr\\\\bin;' .. vim.env.PATH
else
  vim.env.LANG = 'en_US.UTF-8'
end

vim.cmd([[
au VimResized * wincmd =
au TermOpen * setlocal nonumber norelativenumber signcolumn=no
au TermOpen term://* startinsert
]])
