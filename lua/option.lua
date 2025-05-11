local b = vim.b
local g = vim.g
local o = vim.opt
local ol = vim.opt_local
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
o.backup = false
o.breakindent = true
o.clipboard = 'unnamedplus'
o.cursorline = true
o.expandtab = true
o.foldlevel = 99
o.hlsearch = false
o.list = true
o.listchars:append {
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
o.shm:append 'I'
o.showmode = false
o.sidescrolloff = 20
o.signcolumn = 'yes:2'
o.splitkeep = 'screen'
o.statuscolumn = "%s%=%T%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum) : '┊'}│%T"
o.swapfile = false
o.tabstop = 2
o.title = true
o.titlelen = 1000
o.updatetime = 100
o.virtualedit:append 'block'
o.whichwrap:append '<'
o.whichwrap:append '>'
o.whichwrap:append 'h'
o.whichwrap:append 'l'
o.winblend = 10
o.writebackup = false

km('t', '<C-w>', '<C-\\><C-n>', { desc = "Return to normal mode" })
km('n', '/', '/\\c', { desc = "Search forward" })
km('n', '?', '?\\c', { desc = "Search backward" })

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

local ag_option = ag('option', { clear = true })

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
  'TermOpen',
  {
    group = ag_option,
    callback = function()
      ol.number = false
      ol.relativenumber = false
      ol.signcolumn = 'no'
      ol.statuscolumn = ''
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

ac(
  'BufReadPre',
  {
    callback = function()
      local ok, stats = pcall(uv.fs_stat, api.nvim_buf_get_name(api.nvim_get_current_buf()))

      if ok and stats and (stats.size > g.max_file_size_b) then
        b.large_file_buf = true
        ol.foldmethod = "expr"
        return
      end

      b.large_file_buf = false
    end,
    group = ag_option,
  }
)

-- Needs OSC 11
ac({ "UIEnter", "ColorScheme" }, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    if not normal.bg then return end
    io.write(string.format("\027]11;#%06x\027\\", normal.bg))
  end,
})

ac("UILeave", {
  callback = function() io.write("\027]111\027\\") end,
})

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
    vim.cmd.edit(vim.fn.stdpath("config"))
  end,
  {}
)

if fn.executable('lf') == 1 then
  uc(
    "Lf",
    function(opt)
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
        "lf -selection-path " .. cache_sel_path .. " " .. (opt.fargs[1] or "."),
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
