if (vim.fn.has('win64') == 1) then vim.g.os = 'Windows'
else vim.g.os = vim.fn.substitute(vim.fn.system('uname'), '\n', '', '') end

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.g.loaded_netrwPlugin = 0
vim.opt.backup = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.encoding = 'utf-8'
vim.opt.fcs = { eob = nil }
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
vim.opt.scrolloff = 10
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.titlelen = 1000
vim.opt.updatetime = 100
vim.opt.wildmenu = true
vim.opt.wildmode = { 'longest:full', 'full' }
vim.opt.winblend = 10
vim.opt.pumblend = 10
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

local au_option = vim.api.nvim_create_augroup('option', {})

vim.api.nvim_create_autocmd(
  { 'VimResized' },
  {
    group = au_option,
    callback = function()
      vim.cmd.wincmd('=')
    end
  }
)
vim.api.nvim_create_autocmd(
  { 'TermOpen' },
  {
    group = au_option,
    callback = function()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.signcolumn = 'no'
    end
  }
)

vim.api.nvim_create_autocmd(
  { 'TermOpen' },
  {
    group = au_option,
    pattern = { 'term://*' },
    callback = function()
      vim.cmd.startinsert()
    end
  }
)

vim.api.nvim_create_autocmd(
  { 'FileType' },
  {
    group = au_option,
    pattern = { 'help', 'man' },
    callback = function()
      vim.opt_local.signcolumn = 'no'
    end
  }
)

vim.api.nvim_create_autocmd(
  { 'FileType' },
  {
    group = au_option,
    pattern = { 'make' },
    callback = function()
      vim.opt_local.expandtab = false
    end
  }
)

if vim.g.neoray == 1 then
  vim.opt.guifont = 'CascadiaCodePL:h13'

  vim.cmd([[
    NeoraySet KeyZoomIn <C-ScrollWheelUp>
    NeoraySet KeyZoomOut <C-ScrollWheelDown>
    NeoraySet WindowSize 108x40
    NeoraySet WindowState centered
  ]])
end
