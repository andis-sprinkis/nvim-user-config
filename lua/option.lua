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

km({ 'n', 'v' }, '=', '+')
km({ 'n', 'v' }, '+', '=')
km('t', '<C-w>', '<C-\\><C-n>', { desc = "Return to normal mode in terminal buffer" })
km({ 'n', 'v' }, '/', '/\\c', { desc = "Search forward" })
km({ 'n', 'v' }, '?', '?\\c', { desc = "Search backward" })
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
  '<Esc>',
  function()
    vim.cmd.nohlsearch()
    print("")
  end,
  { desc = "Hide search highlight and the command-line message." }
)

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

do
  -- [window view topline is not preserved when switching buffers · Issue #26828 · neovim/neovim](https://github.com/neovim/neovim/issues/26828)
  -- Workaround.
  -- Adapted from https://github.com/BranimirE/fix-auto-scroll.nvim (license: Apache-2.0).
  local saved_buff_view = {}

  ac('BufEnter', {
    group = ag_option,
    pattern = '*',
    callback = function()
      local buf = api.nvim_get_current_buf()
      local win_id = api.nvim_get_current_win()

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
      local buf = api.nvim_get_current_buf()
      local win_id = api.nvim_get_current_win()

      if not saved_buff_view[win_id] then
        saved_buff_view[win_id] = {}
      end

      saved_buff_view[win_id][buf] = fn.winsaveview()
    end
  })
  --
end

do
  local mime_for_editor = {
    'text/*',
    'inode/directory',
    'inode/empty',
    'image/svg%+xml',
    'application/xml',
    'application/*json*',
    'application/xhtml*',
    'application/javascript',
    'application/x%-httpd%-php',
    'application/x%-wine%-extension%-ini',
    'application/x%-mswinurl',
    'application/x%-subrip',
    'application/x%-awk',
  }

  local function open_uri(uri)
    local isUrl = false
    local isFileUrl = false

    local status = {
      err = false,
      uri_input = uri,
      uri_attempted = nil,
      message = nil
    }

    if uri:match('^[%l%u%d]+://') then
      isUrl = true

      if uri:sub(1, 7) == 'file://' then
        isFileUrl = true

        local cmd_uname_output = fn.system({ 'uname', '-n' })

        if (vim.v.shell_error ~= 0) then
          status.err = true
          status.message = '"uname -n" exited with code ' .. vim.v.shell_error

          return status
        end

        local hex_to_char = function(x) return string.char(tonumber(x, 16)) end

        uri = uri:gsub('^file://localhost/', '', 1)
        uri = uri:gsub('^file://' .. fn.trim(cmd_uname_output) .. '/', '', 1)
        uri = uri:gsub('^file://', '', 1)
        uri = uri:gsub('#.*', '', 1)
        uri = uri:gsub('?.*', '', 1)
        uri = uri:gsub('%%([a-f0-9A-F][a-f0-9A-F])', hex_to_char)
      end
    end

    if not isUrl or isFileUrl then
      -- TODO: try the current working dir if the file-relative dir fails ?
      local fp_abs
      local fp_abs_file_relative
      local fp_abs_cwd_relative

      local is_aboslute = true

      if uri:sub(1, 1) ~= '/' then
        local current_file_dir = fn.expand('%:p:h')
        uri = current_file_dir .. '/' .. uri
      end

      local cmd_readlinkf_output = fn.system({ 'readlink', '-f', uri })

      if (vim.v.shell_error ~= 0) then
        status.err = true
        status.message = '"readlink -f" exited with code ' .. vim.v.shell_error
        status.uri_attempted = uri

        return status
      end

      uri = fn.trim(cmd_readlinkf_output)

      local success, err, err_name = uv.fs_stat(uri)

      if not success then
        status.err = true
        status.message = err
        status.uri_attempted = uri

        return status
      end

      local cmd_mime_output = fn.system({ 'file', '--mime-type', '--brief', uri })

      if (vim.v.shell_error ~= 0) then
        status.err = true
        status.message = '"file --mime-type --brief" exited with code ' .. vim.v.shell_error
        status.uri_attempted = uri

        return status
      end

      cmd_mime_output = fn.trim(cmd_mime_output)

      for _, pat in ipairs(mime_for_editor) do
        if string.match(cmd_mime_output, pat) then
          vim.cmd.e(uri)
          status.uri_attempted = uri
          return status
        end
      end
    end

    local comm, err = vim.ui.open(uri)
    local rv = comm and comm:wait(1000) or nil

    if comm and rv and rv.code ~= 0 then
      status.err = true
      status.message = ('vim.ui.open: command %s (%d): %s'):format(
        (rv.code == 124 and 'timeout' or 'failed'),
        rv.code,
        vim.inspect(comm.cmd)
      )
      status.uri_attempted = uri

      return status
    end

    status.err = err ~= nil
    status.message = err
    status.uri_attempted = uri

    return status
  end

  local desc = 'Opens filepath or URI under cursor with the system handler (user)'

  km(
    'n',
    'gx',
    function()
      for _, uri in ipairs(require('vim.ui')._get_urls()) do
        local status = open_uri(uri)

        if status.err then
          vim.notify(status.message .. ' (' .. status.uri_attempted .. ')', vim.log.levels.ERROR)
        else
          vim.notify('Open: ' .. status.uri_attempted, vim.log.levels.INFO)
        end
      end
    end,
    { desc = desc }
  )

  km(
    'x',
    'gx',
    function()
      local lines = fn.getregion(fn.getpos('.'), fn.getpos('v'), { type = fn.mode() })

      -- Trim whitespace on each line and concatenate lines.
      local uri = table.concat(vim.iter(lines):map(vim.trim):totable())

      local status = open_uri(uri)

      if status.err then vim.notify(status.message, vim.log.levels.ERROR) end
    end,
    { desc = desc }
  )
end

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
