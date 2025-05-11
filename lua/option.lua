local g = vim.g
local o = vim.opt
local ol = vim.opt_local
local fn = vim.fn
local cmd = vim.cmd
local loop = vim.loop
local km = vim.keymap.set
local api = vim.api
local env = vim.env
local ag = api.nvim_create_augroup
local ac = api.nvim_create_autocmd
local uc = api.nvim_create_user_command

if vim.fn.has('nvim-0.10') == 1 then
  g.os = vim.uv.os_uname().sysname
else
  g.os = loop.os_uname().sysname
end

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
o.listchars:append {
  eol = '↲',
  extends = '>',
  precedes = '<',
  space = '·',
  tab = '» ',
  trail = '·'
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

if vim.fn.has('nvim-0.8.2') == 1 then
  o.splitkeep = 'screen'
end

if vim.fn.has('nvim-0.10') == 1 then
  o.statuscolumn = "%s%=%T%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum) : '┊'}│%T"
end

o.swapfile = false
o.tabstop = 2
o.title = true
o.titlelen = 1000
o.updatetime = 100
o.virtualedit:append 'block'
o.whichwrap:append '<,>,h,l'
o.winblend = 10
o.writebackup = false

km('t', '<C-w>', '<C-\\><C-n>')
km('n', '<leader>-', ':let @/=expand("%:t") <Bar> execute \'Explore\' expand("%:h") <Bar> normal n<CR>')
km('n', '<leader>b', ":set nomore <Bar> :ls <Bar> :set more <CR>:b<Space>", { silent = true })
km('n', '/', '/\\c')
km('n', '?', '?\\c')

km(
  'n',
  '<leader>a',
  function()
    vim.wo.wrap = not vim.wo.wrap
    vim.notify('vim.wo.wrap = ' .. (vim.wo.wrap and 'true' or 'false'))
  end,
  { desc = "Toggle line wrap" }
)

if not env.LANG then env.LANG = 'en_US.UTF-8' end

local ag_option = ag('option', {})

ac(
  'VimEnter',
  {
    group = ag_option,
    callback = function()
      pcall(function() cmd([[cd %:p:h]]) end)
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

      if vim.fn.has('nvim-0.10') == 1 then
        ol.statuscolumn = ''
      end

      cmd [[startinsert]]
    end
  }
)

ac(
  'FileType',
  {
    group = ag_option,
    pattern = { 'man', 'help', 'vimdoc', 'netrw' },
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
    pattern = { 'netrw' },
    callback = function()
      km('n', '<leader>-', ':let @/=expand("%:t") <Bar> execute \'Explore\' expand("%:h") <Bar> normal n<CR>',
        { buffer = true })
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

if g.os ~= 'Windows_NT' then
  -- Needs OSC 11

  ac({ "UIEnter", "ColorScheme" }, {
    callback = function()
      local normal

      if vim.fn.has('nvim-0.10') == 1 then
        normal = vim.api.nvim_get_hl(0, { name = "Normal" })
      else
        normal = vim.api.nvim_get_hl_by_name("Normal", true)
      end

      if not normal.bg then return end
      io.write(string.format("\027]11;#%06x\027\\", normal.bg))
    end,
  })

  ac("UILeave", {
    callback = function() io.write("\027]111\027\\") end,
  })
end


uc(
  'CopyLocRel',
  function()
    fn.setreg('+', fn.expand('%:.') .. ' ' .. fn.line('.') .. ':' .. fn.col('.') .. '\n')
  end,
  {}
)

uc(
  'CopyLocAbs',
  function()
    fn.setreg('+', fn.expand('%:p') .. ' ' .. fn.line('.') .. ':' .. fn.col('.') .. '\n')
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

uc(
  'ExploreFind',
  'let @/=expand("%:t") | execute \'Explore\' expand("%:h") | normal n',
  { bang = true }
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

      local cmd_select_file = "lf -selection-path " .. cache_sel_path .. " " .. (opt.fargs[1] or ".")

      local on_exit = function()
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
      end

      if vim.fn.has('nvim-0.11') == 1 then
        fn.jobstart(
          cmd_select_file,
          { term = true, on_exit = on_exit }
        )
      else
        fn.termopen(
          cmd_select_file,
          { on_exit = on_exit }
        )
      end

      cmd("startinsert")

      if vim.fn.has('nvim-0.10') == 1 then
        api.nvim_set_option_value('winhl', "Normal:Normal", { win = win })
      else
        api.nvim_win_set_option(win, 'winhl', "Normal:Normal")
      end
    end,
    {
      nargs = "?",
      complete = "dir"
    }
  )
end

if g.neoray == 1 then
  o.guifont = 'CascadiaCodePL:h13'

  cmd([[
    NeoraySet KeyZoomIn <C-ScrollWheelUp>
    NeoraySet KeyZoomOut <C-ScrollWheelDown>
    NeoraySet WindowSize 108x40
    NeoraySet WindowState centered
  ]])
end
