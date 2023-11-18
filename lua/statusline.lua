local api = vim.api
local b = vim.b
local bo = vim.bo
local diagnostic = vim.diagnostic
local fn = vim.fn
local g = vim.g
local lsp = vim.lsp
local o = vim.opt
local wo = vim.wo
local os = g.os
local sys_reqr = g.sys_reqr
local ac = api.nvim_create_autocmd
local ag = api.nvim_create_augroup

local M = {}

if (sys_reqr.lsp_plugins) then
  local lsp_severity = { { 'Warn', 'W' }, { 'Error', 'E' }, { 'Info', 'I' }, { 'Hint', 'H' } }

  function M.lsp_status()
    if vim.tbl_isempty(lsp.buf_get_clients(0)) then return '' end

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

function M.ft() return bo.filetype end

function M.fenc_ffmat()
  local e = bo.fileencoding and bo.fileencoding or o.encoding
  local f = bo.fileformat
  local r = {}

  if e ~= 'utf-8' then r[#r + 1] = e end
  if f ~= 'unix' then r[#r + 1] = '[' .. f .. ']' end

  return table.concat(r, ' ')
end

local fugitive_bname_pattern = os == 'Windows_NT' and [[^fugitive:\\.*\%.git.*\(%x-)\(.*)]] or
    [[^fugitive://.*/%.git.*/(%x-)/(.*)]]

function M.bname()
  local width = math.floor(api.nvim_win_get_width(0) * 0.5)
  local name = fn.fnamemodify(api.nvim_buf_get_name(0), ':.')

  if vim.startswith(name, 'fugitive') then
    local _, commit, relpath
    _, _, commit, relpath = name:find(fugitive_bname_pattern)
    name = relpath .. '@' .. commit:sub(1, 7)
  end

  if #name > width then name = '...' .. name:sub(-width) end

  return name
end

local function pad(x) return '%( ' .. x .. ' %)' end

local function func(name) return '%{%v:lua.statusline.' .. name .. '()%}' end

local dapui_panel_buf = {
  ['dap-repl'] = true,
  ['dap-terminal'] = true,
  dapui_breakpoints = true,
  dapui_console = true,
  dapui_scopes = true,
  dapui_stacks = true,
  dapui_watches = true,
}

local static_dap_panel = table.concat({
  pad(func('bname')),
})

local static_p1 = table.concat({
  '%#StatusLineNC#',
  M.git_hunks and pad(func('git_hunks')) or "",
  M.py_swenv and pad(func('py_swenv')) or "",
  M.lsp_status and pad(func('lsp_status')) or "",
})

local static_p2 = table.concat({
  '%=',
  pad(func('bname') .. '%m%r%h%q'),
  '%=%#StatusLineNC#',
  pad(func('ft')),
  pad(func('fenc_ffmat')),
  ' %3p%% %2l(%02c)/%-3L ',
})

function M.statusline(active)
  if (dapui_panel_buf[vim.bo.filetype]) then
    return table.concat({
      (active and '%#StatusLine#' or '%#StatusLineNC#'),
      static_dap_panel
    })
  end

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
