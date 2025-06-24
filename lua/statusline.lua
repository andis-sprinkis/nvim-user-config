local api = vim.api
local bo = vim.bo
local fn = vim.fn
local o = vim.opt
local wo = vim.wo
local ac = api.nvim_create_autocmd
local ag = api.nvim_create_augroup

local M = {}

function M.ft()
  if vim.bo.filetype ~= '' then
    return vim.bo.filetype
  end

  return vim.b.mime
end

function M.fenc_ffmat()
  local e = bo.fileencoding and bo.fileencoding or o.encoding
  local f = bo.fileformat
  local r = {}

  if e ~= 'utf-8' then r[#r + 1] = e end
  if f ~= 'unix' then r[#r + 1] = '[' .. f .. ']' end

  return table.concat(r, ' ')
end

function M.bname()
  local width = math.floor(api.nvim_win_get_width(0) * 0.5)
  local name = fn.fnamemodify(api.nvim_buf_get_name(0), ':.')

  if #name > width then name = '...' .. name:sub(-width) end

  return name
end

function M.winnr()
  return vim.fn.winnr()
end

local function pad(x) return '%( ' .. x .. ' %)' end

local function func(name) return '%{%v:lua.statusline.' .. name .. '()%}' end

local static_p1 = table.concat({
  '%#StatusLineNC#'
})

local static_p2 = table.concat({
  '%=',
  pad(func('bname')),
  '%=%#StatusLineNC#',
  pad('%h%q%r%m'),
  pad(func('ft')),
  pad(func('fenc_ffmat')),
  pad('%3c %2l/%-L %3p%%'),
  pad(func('winnr')),
})

function M.statusline(active)
  return table.concat({
    static_p1,
    active and '%#StatusLine#' or '%#StatusLineNC#',
    static_p2,
  })
end

local ag_statusline = ag('statusline', {})

local statusline = M.statusline

ac({ 'VimEnter', 'BufWinEnter', 'WinEnter', 'FocusGained' }, {
  group = ag_statusline,
  callback = function() wo.statusline = statusline(true) end
})

ac({ 'WinLeave', 'FocusLost' }, {
  group = ag_statusline,
  callback = function() wo.statusline = statusline(false) end
})

if vim.g.os ~= 'Windows_NT' then
  ac(
    'BufReadPre',
    {
      callback = function()
        if vim.bo.filetype ~= '' then
          vim.b.mime = ''
          return
        end

        local bname = vim.fn.getreg('%')

        if (bname == '') then
          vim.b.mime = ''
          return
        end

        local file = io.open(bname, "r")

        if not file then
          vim.b.mime = ''
          return
        end

        file.close(file)

        local cmd_mime_output = vim.fn.system('file --mime-type --brief "' .. fn.expand('%:p') .. '"')

        if (vim.v.shell_error ~= 0) then vim.b.mime = '' end

        vim.b.mime = vim.fn.trim(cmd_mime_output)
      end,
      group = ag_statusline,
    }
  )
end

_G.statusline = M

return M
