local g = vim.g
local o = vim.opt
local ol = vim.opt_local
local cmd = vim.cmd
local km = vim.keymap.set
local api = vim.api
local env = vim.env
local ag = api.nvim_create_augroup
local ac = api.nvim_create_autocmd

g.man_hard_wrap = true
g.mapleader = ' '
g.netrw_banner = false
g.netrw_liststyle = true
g.netrw_sort_sequence = '[\\/]\\s'
o.backup = false
o.breakindent = true
o.clipboard = 'unnamedplus'
o.cursorline = true
o.expandtab = true
o.foldlevel = 99
o.hlsearch = false
o.list = true
o.listchars:append 'eol:↲'
o.listchars:append 'extends:>'
o.listchars:append 'precedes:<'
o.listchars:append 'space:·'
o.listchars:append 'tab:» '
o.listchars:append 'trail:·'
o.mouse = 'a'
o.number = true
o.pumblend = 10
o.relativenumber = true
o.scrolljump = -100
o.shiftwidth = 2
o.shm:append 'I'
o.showmode = false
o.sidescrolloff = 20
o.signcolumn = 'yes:2'
o.splitbelow = true
if vim.fn.has('nvim-0.8.2') == 1 then
  o.splitkeep = 'screen'
end
if vim.fn.has('nvim-0.10') == 1 then
  o.statuscolumn = "%s%=%T%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum) : '┊'}│%T"
end
o.splitright = true
o.swapfile = false
o.tabstop = 2
o.title = true
o.titlelen = 1000
o.updatetime = 100
o.virtualedit:append 'block'
o.winblend = 10
o.writebackup = false

km({ 'n', 'v' }, 'h', '<bs>')
km({ 'n', 'v' }, 'l', '<space>')
km('n', '<leader>v', cmd.split)
km('n', '<leader>o', cmd.vsplit)
km('t', '<C-w>', '<C-\\><C-n>')
km('n', '<C-A-j>', function() cmd.resize('+2') end)
km('n', '<C-A-k>', function() cmd.resize('-2') end)
km('n', '<C-A-l>', function() cmd('vertical resize +4') end)
km('n', '<C-A-h>', function() cmd('vertical resize -4') end)
km('n', '<C-j>', '<C-W><C-J>')
km('n', '<C-k>', '<C-W><C-K>')
km('n', '<C-l>', '<C-W><C-L>')
km('n', '<C-h>', '<C-W><C-H>')
km('n', '-', ':let @/=expand("%:t") <Bar> execute \'Explore\' expand("%:h") <Bar> normal n<CR>', { silent = true })
km('n', '<leader>b', ":set nomore <Bar> :ls <Bar> :set more <CR>:b<Space>", { silent = true })

km(
  'n',
  '<leader>a',
  function()
    vim.wo.wrap = not vim.wo.wrap
    vim.notify((vim.wo.wrap and 'Enabled' or 'Disabled') .. ' the window line wrap.')
  end
)

if not env.LANG then env.LANG = 'en_US.UTF-8' end

local ag_option = ag('option', {})

ac(
  'VimEnter',
  {
    group = ag_option,
    callback = function()
      pcall(function() cmd.cd('%:p:h') end)
    end
  }
)

ac(
  'VimResized',
  {
    group = ag_option,
    callback = function()
      cmd.wincmd('=')
    end
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
    pattern = { 'man', 'help', 'vimdoc' },
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
    pattern = { 'asm', 'make', 'gitconfig' },
    callback = function()
      ol.expandtab = false
    end
  }
)

ac(
  'FileType',
  {
    group = ag_option,
    pattern = { 'markdown' },
    callback = function()
      ol.formatoptions:append 'r'
    end
  }
)

ac(
  'TextYankPost',
  {
    group = ag_option,
    pattern = '*',
    callback = function()
      vim.highlight.on_yank({ timeout = 170 })
    end,
  }
)

vim.api.nvim_create_user_command(
  'CopyLocRel',
  function()
    vim.fn.setreg('+', vim.fn.expand('%:.') .. ' ' .. vim.fn.line('.') .. ':' .. vim.fn.col('.') .. '\n')
  end,
  {}
)

vim.api.nvim_create_user_command(
  'CopyLocAbs',
  function()
    vim.fn.setreg('+', vim.fn.expand('%:p') .. ' ' .. vim.fn.line('.') .. ':' .. vim.fn.col('.') .. '\n')
  end,
  {}
)

vim.api.nvim_create_user_command(
  'ExploreFind',
  'let @/=expand("%:t") | execute \'Explore\' expand("%:h") | normal n',
  { bang = true }
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
