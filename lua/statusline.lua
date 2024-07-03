local api = vim.api
local bo = vim.bo
local fn = vim.fn
local o = vim.opt
local wo = vim.wo
local ac = api.nvim_create_autocmd
local ag = api.nvim_create_augroup

local M = {}

function M.ft() return bo.filetype end

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

local function pad(x) return '%( ' .. x .. ' %)' end

local function func(name) return '%{%v:lua.statusline.' .. name .. '()%}' end

local static_p1 = table.concat({
  '%#StatusLineNC#',
})

local static_p2 = table.concat({
  '%=',
  pad(func('bname')),
  '%=%#StatusLineNC#',
  pad('%h%q%r%m'),
  pad(func('ft')),
  pad(func('fenc_ffmat')),
  pad('%3c %2l/%-L'),
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

_G.statusline = M

return M
