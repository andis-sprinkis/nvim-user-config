local M = {
  "_virt_statusline",
  virtual = true,
  config = function()
    local api = vim.api
    local b = vim.b
    local w = vim.w
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

    local lsp_severity = { { 'WARN', 'W' }, { 'ERROR', 'E' }, { 'INFO', 'I' }, { 'HINT', 'H' } }
    local label_large_file_buf = '[Size >' .. tostring(g.max_file_size_kb) .. 'K]'

    function M.large_file_buf() return b.large_file_buf and label_large_file_buf or '' end

    local function pad(x) return '%( ' .. x .. ' %)' end
    local function pad_l(x) return '%( ' .. x .. '%)' end
    local function pad_r(x) return '%(' .. x .. ' %)' end

    local function func(name) return '%{%v:lua.statusline.' .. name .. '()%}' end

    local static_p1 =
        pad_l('%{b:statusline_git_hunks}')
        .. (sys_reqr.swenv and pad_l('%{b:statusline_py_swenv}') or "")
        .. (sys_reqr.lsp_plugins and pad_l('%{b:statusline_lsp_status}') or "")

    if string.len(static_p1) then
      static_p1 = pad_r(static_p1)
    end

    local static_p2 =
        '%='
        .. pad('%{w:statusline_bname}')
        .. '%=%#StatusLineNC# '
        .. pad_r(func('large_file_buf') .. '%h%q%r%m')
        .. pad_r('%{b:statusline_mime_ft}')
        .. pad_r('%{b:statusline_fenc_ffmat}')
        .. pad_r('%3c %2l/%-L %3p%%')

    function M.statusline(active)
      return
          '%#StatusLineNC#'
          .. static_p1
          .. (active and '%#StatusLine#' or '%#StatusLineNC#')
          .. static_p2
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

    local function set_statusline_fenc_ffmat()
      local e = bo.fileencoding and bo.fileencoding or o.encoding
      local f = bo.fileformat
      local r = {}

      if e ~= 'utf-8' then r[#r + 1] = e end
      if f ~= 'unix' then r[#r + 1] = '[' .. f .. ']' end

      vim.b.statusline_fenc_ffmat = table.concat(r, ' ')
    end

    local function set_statusline_mime_ft()
      if bo.filetype and bo.filetype ~= '' then
        b.statusline_mime_ft = vim.bo.filetype
        return
      end

      local bname = vim.fn.getreg('%')

      if (bname == '') then
        b.statusline_mime_ft = ''
        return
      end

      local file = io.open(bname, "r")

      if not file then
        b.statusline_mime_ft = ''
        return
      end

      file.close(file)

      local cmd_mime_output = fn.system('file --mime-type --brief "' .. fn.expand('%:p') .. '"')

      if (vim.v.shell_error ~= 0) then b.statusline_mime_ft = '' end

      b.statusline_mime_ft = fn.trim(cmd_mime_output)
    end

    local function set_statusline_py_swenv()
      if sys_reqr.swenv then
        local swenv_api = require("swenv.api")
        local venv = swenv_api.get_current_venv()

        b.statusline_py_swenv = venv and "venv:" .. venv.name or ''
      end
    end

    local function set_statusline_git_hunks()
      if b.gitsigns_status then
        b.statusline_git_hunks = b.gitsigns_status == '' and b.gitsigns_head or
            b.gitsigns_head .. ' ' .. b.gitsigns_status
        return
      end

      b.statusline_git_hunks = g.gitsigns_head and g.gitsigns_head or ''
    end

    local function set_statusline_bname()
      -- TODO: update on all visible windows

      local width = math.floor(api.nvim_win_get_width(0) * 0.5)
      local name = fn.fnamemodify(api.nvim_buf_get_name(0), ':.')

      if #name > width then name = '...' .. name:sub(-width) end

      w.statusline_bname = name
    end

    local function set_statusline_lsp_status()
      if vim.tbl_isempty(lsp.get_clients({ bufnr = 0 })) then
        vim.b.statusline_lsp_status = ''
        return
      end

      local status = {}

      for _, ty in ipairs(lsp_severity) do
        local n = diagnostic.get(0, { severity = ty[1] })
        if #n > 0 then table.insert(status, ty[2] .. ':' .. #n) end
      end

      vim.b.statusline_lsp_status = table.concat(status, ' ')
    end

    ac(
      {
        'FileType',
        'BufWinEnter',
        'BufEnter',
        'FileChangedShellPost',
        'VimResume'
      },
      {
        callback = function()
          set_statusline_mime_ft()
          set_statusline_fenc_ffmat()
          set_statusline_git_hunks()
          set_statusline_py_swenv()
        end,
        group = ag_statusline,
      }
    )

    -- TODO: check for the events when gitsigns variables update
    ac(
      {
        'SafeState',
        'TextChanged',
        'TextChangedI',
        'CursorHold',
        'CursorHoldI'
      },
      {
        callback = function()
          set_statusline_git_hunks()
          set_statusline_lsp_status()
        end,
        group = ag_statusline,
      }
    )

    ac(
      {
        'BufWinEnter',
        'BufEnter',
        'VimResized',
        'WinNew',
        'WinResized',
        'WinEnter',
        'OptionSet',
      },
      {
        callback = function()
          set_statusline_bname()
        end,
        group = ag_statusline,
      }
    )

    _G.statusline = M

    return M
  end,
  dependencies = {
    'AckslD/swenv.nvim',
    'lewis6991/gitsigns.nvim',
    'mason-org/mason.nvim',
  }
}

return M
