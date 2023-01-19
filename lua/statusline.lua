local M = {}

function M.lsp_status()
  if (not vim.g.sys_reqr.lsp_plugins) or vim.tbl_isempty(vim.lsp.buf_get_clients(0)) then return '' end

  local status = {}

  for _, ty in ipairs { 'Warn', 'Error', 'Info', 'Hint' } do
    local n = vim.diagnostic.get(0, { severity = ty })

    if #n > 0 then table.insert(status, (' %s:%s'):format(ty:sub(1, 1), #n)) end
  end

  local r = table.concat(status, ' ')

  return r == '' and 'LSP' or r
end

function M.git_hunks()
  if not vim.g.sys_reqr.git_plugins then return '' end

  if vim.b.gitsigns_status then
    return vim.b.gitsigns_status == '' and vim.b.gitsigns_head or vim.b.gitsigns_head .. ' ' .. vim.b.gitsigns_status
  end

  return vim.g.gitsigns_head and vim.g.gitsigns_head or ''
end

function M.py_swenv()
  if (not vim.g.sys_reqr.swenv) then return '' end

  local venv = require('swenv.api').get_current_venv()

  return venv and "venv:" .. venv.name or ''
end

function M.ft() return vim.bo.filetype end

function M.fenc_ffmat()
  local e = vim.bo.fileencoding and vim.bo.fileencoding or vim.o.encoding

  local r = {}
  if e ~= 'utf-8' then
    r[#r + 1] = e
  end

  local f = vim.bo.fileformat
  if f ~= 'unix' then r[#r + 1] = '[' .. f .. ']' end

  return table.concat(r, ' ')
end

function M.bname()
  local ratio = 0.5
  local width = math.floor(vim.api.nvim_win_get_width(0) * ratio)
  local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':.')

  if (vim.g.sys_reqr.git_plugins and vim.startswith(name, 'fugitive')) then
    local _, commit, relpath

    if (vim.g.os == 'Windows') then
      _, _, commit, relpath = name:find([[^fugitive:\\.*\%.git.*\(%x-)\(.*)]])
    else
      _, _, commit, relpath = name:find([[^fugitive://.*/%.git.*/(%x-)/(.*)]])
    end

    name = relpath .. '@' .. commit:sub(1, 7)
  end

  if #name > width then
    name = '...' .. name:sub(-width)
  end

  return name
end

local function highlight(num, active) return (active == 1 and num ~= 1) and '%#StatusLine#' or '%#StatusLineNC#' end
local function pad(x) return '%( ' .. x .. ' %)' end
local function func(name) return '%{%v:lua.statusline.' .. name .. '()%}' end

function M.statusline(active)
  return table.concat {
    highlight(1, active),
    pad(func('git_hunks')),
    pad(func('py_swenv')),
    highlight(2, active),
    pad(func('lsp_status')),
    '%=',
    pad(func('bname') .. '%m%r%h%q'),
    '%=',
    pad(func('ft')),
    pad(func('fenc_ffmat')),
    highlight(1, active),
    ' %3p%% %2l(%02c)/%-3L ',
  }
end

local au_statusline = vim.api.nvim_create_augroup('statusline', {})

vim.api.nvim_create_autocmd({ 'VimEnter', 'BufWinEnter', 'WinEnter', 'FocusGained' }, {
  group = au_statusline,
  callback = function() vim.wo.statusline = _G.statusline.statusline(1) end
})

vim.api.nvim_create_autocmd({ 'WinLeave', 'FocusLost' }, {
  group = au_statusline,
  callback = function() vim.wo.statusline = _G.statusline.statusline(0) end
})

_G.statusline = M

return M
