local api = vim.api
local b = vim.b
local bo = vim.bo
local diagnostic = vim.diagnostic
local fn = vim.fn
local g = vim.g
local lsp = vim.lsp
local o = vim.opt
local wo = vim.wo
local sys_reqr = g.sys_reqr
local ac = api.nvim_create_autocmd
local ag = api.nvim_create_augroup

local M = {}

if (sys_reqr.lsp_plugins) then
  local lsp_severity = { { 'WARN', 'W' }, { 'ERROR', 'E' }, { 'INFO', 'I' }, { 'HINT', 'H' } }

  function M.lsp_status()
    if vim.tbl_isempty(lsp.get_clients({ bufnr = 0 })) then return '' end

    local status = {}

    for _, ty in ipairs(lsp_severity) do
      local n = diagnostic.get(0, { severity = ty[1] })
      if #n > 0 then table.insert(status, ty[2] .. ':' .. #n) end
    end

    return table.concat(status, ' ')
  end
end

local status_gitsigns, gitsigns = pcall(require, "gitsigns")

if (status_gitsigns) then
  function M.git_hunks()
    if b.gitsigns_status then
      return b.gitsigns_status == '' and b.gitsigns_head or b.gitsigns_head .. ' ' .. b.gitsigns_status
    end

    return g.gitsigns_head and g.gitsigns_head or ''
  end
end

if sys_reqr.swenv then
  local status_swenv, swenv_api = pcall(require, "swenv.api")

  if (status_swenv) then
    function M.py_swenv()
      local venv = swenv_api.get_current_venv()

      return venv and "venv:" .. venv.name or ''
    end
  end
end

function M.ft()
  if vim.bo.filetype and vim.bo.filetype ~= '' then
    return vim.bo.filetype
  end

  if vim.b.mime and vim.b.mime ~= '' then
    return vim.b.mime
  end

  return ''
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

local label_large_file_buf = '[Size >' .. tostring(g.max_file_size_kb) .. 'K]'

function M.large_file_buf() return vim.b.large_file_buf and label_large_file_buf or '' end

local function pad(x) return '%( ' .. x .. ' %)' end

local function func(name) return '%{%v:lua.statusline.' .. name .. '()%}' end

local static_p1 = table.concat({
  '%#StatusLineNC#',
  M.git_hunks and pad(func('git_hunks')) or "",
  M.py_swenv and pad(func('py_swenv')) or "",
  M.lsp_status and pad(func('lsp_status')) or "",
})

local static_p2 = table.concat({
  '%=',
  pad(func('bname')),
  '%=%#StatusLineNC#',
  pad(func('large_file_buf') .. '%h%q%r%m'),
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

ac(
  'BufReadPre',
  {
    callback = function()
      if vim.bo.filetype and vim.bo.filetype ~= '' then
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

_G.statusline = M

return M
