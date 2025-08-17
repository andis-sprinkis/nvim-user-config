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
local ag = api.nvim_create_augroup
local ac = api.nvim_create_autocmd
local uc = api.nvim_create_user_command

g.os = uv.os_uname().sysname
g.sys_reqr = {}
g.exec = {}
g.max_file_size_kb = 100
g.max_file_size_b = 1024 * g.max_file_size_kb -- 1024 * KB

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

km({ 'n', 'v' }, '=', '+')
km({ 'n', 'v' }, '+', '=')
km('t', '<C-w>', '<C-\\><C-n>', { desc = "Return to normal mode in terminal buffer" })
km({ 'n', 'v' }, '/', '/\\c', { desc = "Search forward" })
km({ 'n', 'v' }, '?', '?\\c', { desc = "Search backward" })
km('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = "Hide search highlight" })
km('n', '<leader>v', cmd.split, { desc = "Split window (split)" })
km('n', '<leader>o', cmd.vsplit, { desc = "Split window (vsplit)" })
km('n', '<C-A-j>', function() cmd.resize('+2') end, { desc = "Increase window size (resize)" })
km('n', '<C-A-k>', function() cmd.resize('-2') end, { desc = "Decrease window size (resize)" })
km('n', '<C-A-l>', function() cmd('vertical resize +4') end, { desc = "Increase window size (vertical resize)" })
km('n', '<C-A-h>', function() cmd('vertical resize -4') end, { desc = "Decrease window size (vertical resize)" })
km('n', '<leader>j', '<C-w>j', { desc = "Move cursor to window above current one" })
km('n', '<leader>k', '<C-w>k', { desc = "Move cursor to window below current one" })
km('n', '<leader>l', '<C-w>l', { desc = "Move cursor to window left of current one" })
km('n', '<leader>h', '<C-w>h', { desc = "Move cursor to window right of current one" })

km(
  'n',
  '<leader>a',
  function()
    vim.wo.wrap = not vim.wo.wrap
    vim.notify('vim.wo.wrap = ' .. (vim.wo.wrap and 'true' or 'false'))
  end,
  { desc = "Toggle line wrap" }
)

if not env.LANG then
  env.LANG = 'en_US.UTF-8'
end

env.PATH = fn.stdpath('config') .. '/bin:' .. env.PATH

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
      cmd([[wincmd =]])
    end
  }
)

ac(
  'TermOpen',
  {
    group = ag_option,
    callback = function()
      optl.number = false
      optl.relativenumber = false
      optl.signcolumn = 'no'
      optl.statuscolumn = ''
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
      optl.number = true
      optl.relativenumber = true
    end
  }
)

ac(
  'FileType',
  {
    group = ag_option,
    pattern = { 'asm', 'make', 'gitconfig' },
    callback = function()
      optl.expandtab = false
    end
  }
)

ac(
  'FileType',
  {
    group = ag_option,
    pattern = { 'markdown' },
    callback = function()
      optl.formatoptions:append 'r'
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

ac(
  'BufReadPre',
  {
    callback = function()
      local ok, stats = pcall(uv.fs_stat, api.nvim_buf_get_name(api.nvim_get_current_buf()))

      if ok and stats and (stats.size > g.max_file_size_b) then
        b.large_file_buf = true
        optl.foldmethod = "expr"
        return
      end

      b.large_file_buf = false
    end,
    group = ag_option,
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
    group = ag_option,
  }
)
--

-- [window view topline is not preserved when switching buffers · Issue #26828 · neovim/neovim](https://github.com/neovim/neovim/issues/26828)
-- Workaround.
-- Adapted from https://github.com/BranimirE/fix-auto-scroll.nvim (license: Apache-2.0).
local saved_buff_view = {}

ac('BufEnter', {
  group = ag_option,
  pattern = '*',
  callback = function()
    local buf = fn.bufnr("%")
    local win_id = fn.win_getid()

    if saved_buff_view[win_id] and saved_buff_view[win_id][buf] then
      local v = fn.winsaveview()

      if v.lnum == 1 and v.col == 0 and not api.nvim_get_option_value('diff', {}) then
        fn.winrestview(saved_buff_view[win_id][buf])
      end

      saved_buff_view[win_id][buf] = nil
    end
  end
})

ac('BufLeave', {
  group = ag_option,
  pattern = '*',
  callback = function()
    local buf = fn.bufnr("%")
    local win_id = fn.win_getid()

    if not saved_buff_view[win_id] then
      saved_buff_view[win_id] = {}
    end

    saved_buff_view[win_id][buf] = fn.winsaveview()
  end
})
--

uc(
  'CopyLocRel',
  function()
    fn.setreg('+', fn.expand('%:.') .. ':' .. fn.line('.') .. ':' .. fn.col('.') .. '\n')
  end,
  {}
)

uc(
  'CopyLocAbs',
  function()
    fn.setreg('+', fn.expand('%:p') .. ':' .. fn.line('.') .. ':' .. fn.col('.') .. '\n')
  end,
  {}
)

uc(
  'Config',
  function()
    vim.cmd.edit(fn.stdpath("config"))
  end,
  {}
)

-- Opening the lf file manager in a floating terminal window.
-- Adapted from https://github.com/is0n/fm-nvim (license: GPL-3.0)
if fn.executable('lf') == 1 then
  uc(
    "Lf",
    function(option)
      local buf = api.nvim_create_buf(false, true)

      local win = api.nvim_open_win(
        buf,
        true,
        {
          style = "minimal",
          relative = "editor",
          width = api.nvim_get_option_value("columns", {}),
          height = api.nvim_get_option_value("lines", {}) - 1,
          col = 0,
          row = 0
        }
      )

      ac(
        "VimResized",
        {
          group = ag("LfWindow", {}),
          buffer = buf,
          callback = function()
            api.nvim_win_set_width(win, api.nvim_get_option_value("columns", {}))
            api.nvim_win_set_height(win, api.nvim_get_option_value("lines", {}) - 1)
          end,
        }
      )

      local cache_sel_path = fn.stdpath("cache") .. "/lf_sel_path"

      fn.jobstart(
        "lf -selection-path " .. cache_sel_path .. " " .. (option.fargs[1] or "."),
        {
          term = true,
          on_exit = function()
            api.nvim_win_close(win, true)
            api.nvim_buf_delete(buf, { force = true })

            if io.open(cache_sel_path, "r") ~= nil then
              for line in io.lines(cache_sel_path) do
                cmd("edit " .. fn.fnameescape(line))
              end

              io.close(io.open(cache_sel_path, "r"))
              os.remove(cache_sel_path)
            end

            cmd.checktime()
          end,
        }
      )

      cmd("startinsert")

      api.nvim_set_option_value('winhl', "Normal:Normal", { win = win })
    end,
    {
      nargs = "?",
      complete = "dir"
    }
  )
end
--
