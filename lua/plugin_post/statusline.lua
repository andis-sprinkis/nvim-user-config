local M = {}

local function highlight(num, active)
  if active == 1 then
    if num == 1 then
      return '%#StatusLineNC#'
    else
      return '%#StatusLine#'
    end
  else
    return '%#StatusLineNC#'
  end
end

function M.hldefs()
  local bg = vim.api.nvim_get_hl_by_name('StatusLine', true).background
  for _, ty in ipairs { 'Warn', 'Error', 'Info', 'Hint' } do
    local hl = vim.api.nvim_get_hl_by_name('Diagnostic' .. ty, true)
    if (bg ~= nil and bg > 255) then
      vim.cmd(('highlight Diagnostic%sStatus guifg=#%6x guibg=#%6x'):format(ty, hl.foreground, bg))
    else
      vim.cmd(('highlight Diagnostic%sStatus guifg=#%6x'):format(ty, hl.foreground))
    end
  end
end

function M.lsp_status(active)
  if vim.tbl_isempty(vim.lsp.buf_get_clients(0)) then
    return ''
  end

  local status = {}

  for _, ty in ipairs { 'Warn', 'Error', 'Info', 'Hint' } do
    local n = vim.diagnostic.get(0, { severity = ty })
    if #n > 0 then
      if active == 1 then
        table.insert(status, ('%%#Diagnostic%sStatus# %s:%s'):format(ty, ty:sub(1, 1), #n))
      else
        table.insert(status, (' %s:%s'):format(ty:sub(1, 1), #n))
      end
    end
  end

  local r = table.concat(status, ' ')

  return r == '' and 'LSP' or r
end

function M.hunks()
  if vim.b.gitsigns_status then
    local status = vim.b.gitsigns_head
    if vim.b.gitsigns_status ~= '' then
      status = status .. ' ' .. vim.b.gitsigns_status
    end
    return status
  elseif vim.g.gitsigns_head then
    return vim.g.gitsigns_head
  end
  return ''
end

function M.blame()
  if vim.b.gitsigns_blame_line_dict then
    local info = vim.b.gitsigns_blame_line_dict
    local date_time = require('gitsigns.util').get_relative_time(tonumber(info.author_time))
    return string.format('%s - %s', info.author, date_time)
  end
  return ''
end

function M.filetype()
  return vim.bo.filetype
end

function M.encodingAndFormat()
  local e = vim.bo.fileencoding and vim.bo.fileencoding or vim.o.encoding

  local r = {}
  if e ~= 'utf-8' then
    r[#r + 1] = e
  end

  local f = vim.bo.fileformat
  if f ~= 'unix' then
    r[#r + 1] = '[' .. f .. ']'
  end

  return table.concat(r, ' ')
end

function M.bufname()
  local ratio = 0.5
  local width = math.floor(vim.api.nvim_win_get_width(0) * ratio)
  local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':.')
  if vim.startswith(name, 'fugitive') then
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

local function pad(x)
  return '%( ' .. x .. ' %)'
end

local function func(name, active)
  active = active or 1
  return '%{%v:lua.statusline.' .. name .. '(' .. tostring(active) .. ')%}'
end

function M.statusline(active)
  return table.concat {
    highlight(1, active),
    pad(func('hunks')),
    highlight(2, active),
    pad(func('lsp_status', active)),
    highlight(2, active),
    '%=',
    pad(func('bufname') .. '%m%r%h%q'),
    -- '%<%0.60f%m%r',  -- file.txt[+][RO]
    '%=',
    pad(func('filetype')),
    pad(func('encodingAndFormat')),
    highlight(1, active),
    ' %3p%% %2l(%02c)/%-3L ', -- 80% 65[12]/120
  }
end

-- Only set up WinEnter autocmd when the WinLeave autocmd runs
vim.cmd [[
  augroup statusline
    autocmd BufWinEnter,WinEnter,FocusGained * let &l:statusline=v:lua.statusline.statusline(1)
    autocmd WinLeave,FocusLost   * let &l:statusline=v:lua.statusline.statusline(0)
    autocmd VimEnter             * let &statusline=v:lua.statusline.statusline(1)
    " autocmd ColorScheme,VimEnter * lua statusline.hldefs()
  augroup END
]]

_G.statusline = M

return M
