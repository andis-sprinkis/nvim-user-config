local b = vim.b
local g = vim.g
local o = vim.o
local opt = vim.opt
local optl = vim.opt_local
local fn = vim.fn
local cmd = vim.cmd
local km = vim.keymap.set
local api = vim.api
local env = vim.env
local uv = vim.uv
local ac = api.nvim_create_autocmd
local uc = api.nvim_create_user_command

g.sys_reqr = {}
g.exec = {}
g.maxfsize_kb = 100
g.maxfsize_b = 1024 * g.maxfsize_kb -- 1024 * KB

g.loaded_netrwPlugin = 0
g.man_hard_wrap = true
g.mapleader = ' '
g.maplocalleader = ' '
o.backup = false
o.breakindent = true
vim.schedule(function()
  o.clipboard = 'unnamedplus'
end)
o.cursorline = true
o.expandtab = true
o.foldlevel = 99
o.foldlevelstart = 99
o.list = true
opt.listchars:append {
  eol = '↲',
  extends = '>',
  precedes = '<',
  tab = '» ',
}
o.mouse = 'a'
o.mousescroll = 'ver:6,hor:12'
o.number = true
o.pumblend = 10
o.relativenumber = true
o.scrolljump = -100
o.shiftwidth = 2
opt.shm:append 'I'
o.showmode = false
o.sidescrolloff = 20
o.signcolumn = 'yes:2'
o.splitkeep = 'screen'
o.splitright = true
o.splitbelow = true
o.statuscolumn = "%s%=%T%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum) : '┊'} %T"
o.swapfile = false
o.tabstop = 2
o.timeoutlen = 300
o.title = true
o.titlelen = 1000
o.titlestring = '%t%(%M%)%( (%{expand("%:~:h")})%)%a'
o.updatetime = 150
opt.virtualedit:append 'block'
opt.whichwrap:append '<,>,h,l'
o.winblend = 10
o.writebackup = false

if not env.LANG then
  env.LANG = 'en_US.UTF-8'
end

env.PATH = fn.stdpath('config') .. '/bin:' .. env.PATH

cmd.aunmenu("PopUp.How-to\\ disable\\ mouse")
cmd.amenu("PopUp.-2-", "<Nop>")
cmd.amenu("PopUp.Up\\ directory", "<Plug>(dirvish_up)")
cmd.amenu("PopUp.Quit", "<Cmd>q<CR>")

-- km({ 'n', 'v' }, '=', '+')
-- km({ 'n', 'v' }, '+', '=')
km('t', '<C-w>', '<C-\\><C-n>', { desc = "Return to normal mode in terminal buffer (user)" })
km({ 'n', 'v' }, '/', '/\\c', { desc = "Search forward (user)" })
km({ 'n', 'v' }, '?', '?\\c', { desc = "Search backward (user)" })
km('n', '<leader>v', cmd.split, { desc = "Split window (split) (user)" })
km('n', '<leader>o', cmd.vsplit, { desc = "Split window (vsplit) (user)" })
km('n', '<C-A-j>', function() cmd.resize('+2') end, { desc = "Increase window size (resize) (user)" })
km('n', '<C-A-k>', function() cmd.resize('-2') end, { desc = "Decrease window size (resize) (user)" })
km('n', '<C-A-l>', function() cmd('vertical resize +4') end, { desc = "Increase window size (vertical resize) (user)" })
km('n', '<C-A-h>', function() cmd('vertical resize -4') end, { desc = "Decrease window size (vertical resize) (user)" })
km('n', '<leader>j', '<C-w>j', { desc = "Move cursor to window above current one (user)" })
km('n', '<leader>k', '<C-w>k', { desc = "Move cursor to window below current one (user)" })
km('n', '<leader>l', '<C-w>l', { desc = "Move cursor to window left of current one (user)" })
km('n', '<leader>h', '<C-w>h', { desc = "Move cursor to window right of current one (user)" })

km(
  'n',
  '<Esc>',
  function()
    vim.cmd.nohlsearch()
    print("")
  end,
  { desc = "Hide search highlight and the command-line message (user)" }
)

km(
  'n',
  '<leader>a',
  function()
    vim.wo.wrap = not vim.wo.wrap
    vim.notify('vim.wo.wrap = ' .. (vim.wo.wrap and 'true' or 'false'))
  end,
  { desc = "Toggle line wrap (user)" }
)

ac(
  'VimEnter',
  {
    callback = function()
      pcall(function() cmd.cd('%:p:h') end)
    end,
    desc = "Change the current directory to the current file directory (user)"
  }
)

ac(
  'VimResized',
  {
    command = "wincmd =",
    desc = "Make all windows equally high and wide (user)"
  }
)

ac(
  'TermOpen',
  {
    callback = function()
      optl.number = false
      optl.relativenumber = false
      optl.signcolumn = 'no'
      optl.statuscolumn = ''
      cmd.startinsert()
    end,
    desc = "Set buffer options and start in insert mode (user)"
  }
)

ac(
  'FileType',
  {
    pattern = { 'man', 'help', 'vimdoc' },
    callback = function()
      optl.number = true
      optl.relativenumber = true
    end,
    desc = "Enable 'number' and 'relativenumber' (user)"
  }
)

ac(
  'FileType',
  {
    pattern = { 'asm', 'make', 'gitconfig' },
    callback = function()
      optl.expandtab = false
    end,
    desc = "Disable 'expandtab' (user)"
  }
)

ac(
  'FileType',
  {
    pattern = { 'markdown' },
    callback = function()
      optl.formatoptions:append 'r'
    end,
    desc = "Extend 'formatoptions' with 'r' (user)"
  }
)

ac(
  'TextYankPost',
  {
    pattern = '*',
    callback = function()
      vim.highlight.on_yank({ timeout = 170 })
    end,
    desc = "Highlight text yank (user)"
  }
)

ac(
  { 'BufReadPre', 'BufWritePost', 'FileChangedShell' },
  {
    callback = function()
      local ok, stats = pcall(uv.fs_stat, api.nvim_buf_get_name(api.nvim_get_current_buf()))

      if ok and stats and (stats.size > g.maxfsize_b) then
        b.largef = true
        optl.foldmethod = "expr"
        return
      end

      b.largef = false
    end,
    desc = "Determine if the current file is large (user)"
  }
)

ac(
  'BufEnter',
  {
    callback = function()
      optl.ro = false
    end,
    desc = "Disable 'ro' (user)"
  }
)

-- mkdir on save.
-- Adapted from https://github.com/jghauser/mkdir.nvim (License: GPL-3.0)
ac(
  'BufWritePre',
  {
    callback = function()
      local dir = fn.expand('<afile>:p:h')

      if dir:find('%l+://') == 1 then
        return
      end

      if fn.isdirectory(dir) == 0 then
        fn.mkdir(dir, 'p')
      end
    end,
    desc = "Create nested directories for the current file (user)"
  }
)
--

uc(
  'CopyLocRel',
  function()
    fn.setreg('+', fn.expand('%:.') .. ':' .. fn.line('.') .. ':' .. fn.col('.') .. '\n')
  end,
  { desc = "Write the relative file path, line and column number into the '+' selection register (user)" }
)

uc(
  'CopyLocAbs',
  function()
    fn.setreg('+', fn.expand('%:p') .. ':' .. fn.line('.') .. ':' .. fn.col('.') .. '\n')
  end,
  { desc = "Write the absolute file path, line and column number into the '+' selection register (user)" }
)

uc(
  'Scrap',
  function()
    local cmd_scrap_path_output = fn.system({ 'scrap', 'path' })

    if (vim.v.shell_error ~= 0) then
      vim.notify('Failed to get the scrap note file path', vim.log.levels.ERROR)
      return
    end

    cmd.e(fn.trim(cmd_scrap_path_output))
  end,
  { desc = "Open a new scrap note buffer (user)" }
)

uc(
  'Config',
  function()
    vim.cmd.edit(fn.stdpath("config"))
  end,
  { desc = "Open user configuration director (user)" }
)

for alias, fcmd in pairs({
  C = 'Config',
  H = 'help',
  M = 'Man',
  S = 'Scrap',
  man = 'Man',
  scrap = 'Scrap',
}) do
  km(
    'ca',
    alias,
    function() return (vim.fn.getcmdtype() == ':' and vim.fn.getcmdline() == alias) and fcmd or alias end,
    {
      expr = true,
      desc = "Expand command alias \"" .. alias .. "\" to command \"" .. fcmd .. "\" (user)"
    }
  )
end
