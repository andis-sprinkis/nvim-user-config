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

    local function pad(x) return '%( ' .. x .. ' %)' end
    local function pad_l(x) return '%( ' .. x .. '%)' end
    local function pad_r(x) return '%(' .. x .. ' %)' end
    local function var_exists(x) return '%{exists(\'' .. x .. '\')?' .. x .. ':\'\'}' end

    local static_p1 =
        '%#StatusLineNC#'
        .. pad_l(var_exists('b:statusline_git_hunks'))
        .. (sys_reqr.swenv and pad_l(var_exists('b:statusline_py_swenv')) or '')
        .. (sys_reqr.lsp_plugins and pad_l(var_exists('b:statusline_lsp_status')) or "")

    if string.len(static_p1) then
      static_p1 = pad_r(static_p1)
    end

    local static_p2 =
        '%='
        .. pad(var_exists('w:statusline_bname'))
        .. '%=%#StatusLineNC# '
        .. pad_r(var_exists('b:statusline_large_file_buf') .. '%h%q%r%m')
        .. pad_r(var_exists('b:statusline_mime_ft'))
        .. pad_r(var_exists('b:statusline_fenc_ffmat'))
        .. pad_r('%3c %2l/%-L %3p%%')

    local function statusline(active)
      return
          static_p1
          .. (active and '%#StatusLine#' or '%#StatusLineNC#')
          .. static_p2
    end

    local large_file_buf_fmat = '[Size >' .. tostring(g.max_file_size_kb) .. 'K]'

    local function set_statusline_large_file_buf()
      b.statusline_large_file_buf = b.large_file_buf and large_file_buf_fmat or ''
    end

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
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local max_width = math.floor(api.nvim_win_get_width(win) * 0.5)
        local name = fn.fnamemodify(api.nvim_buf_get_name(fn.getwininfo(win)[1].bufnr), ':.')
        if #name > max_width then name = '...' .. name:sub(-max_width) end
        w[win].statusline_bname = name
      end
    end

    local lsp_severity = { { 'WARN', 'W' }, { 'ERROR', 'E' }, { 'INFO', 'I' }, { 'HINT', 'H' } }

    local function set_statusline_lsp_status()
      if vim.tbl_isempty(lsp.get_clients({ bufnr = 0 })) then
        b.statusline_lsp_status = ''
        return
      end

      local status = {}

      for _, ty in ipairs(lsp_severity) do
        local n = diagnostic.get(0, { severity = ty[1] })
        if #n > 0 then table.insert(status, ty[2] .. ':' .. #n) end
      end

      b.statusline_lsp_status = table.concat(status, ' ')
    end

    local ag_statusline = ag('statusline', {})

    ac(
      {
        'BufEnter',
        'BufNew',
        'BufWinEnter',
        'BufWritePost',
        'FileChangedShellPost',
        'FileType',
        'VimResume',
      },
      {
        callback = set_statusline_large_file_buf,
        group = ag_statusline,
      }
    )

    ac(
      {
        'BufEnter',
        'BufNew',
        'BufWinEnter',
        'BufWritePost',
        'FileChangedShellPost',
        'FileType',
        'VimResume'
      },
      {
        callback = set_statusline_mime_ft,
        group = ag_statusline,
      }
    )

    ac(
      {
        'BufEnter',
        'BufNew',
        'BufWinEnter',
        'BufWritePost',
        'FileChangedShellPost',
        'FileType',
        'VimResume'
      },
      {
        callback = set_statusline_fenc_ffmat,
        group = ag_statusline,
      }
    )

    ac(
      {
        'BufEnter',
        'BufNew',
        'BufWinEnter'
      },
      {
        callback = set_statusline_py_swenv,
        group = ag_statusline,
      }
    )

    ac(
      {
        'BufEnter',
        'BufWinEnter',
        'BufWritePost',
        'CursorHold',
        'CursorHoldI',
        'FileChangedShellPost',
        'ModeChanged',
        'VimResume'
      },
      {
        callback = set_statusline_lsp_status,
        group = ag_statusline,
      }
    )

    ac(
      {
        'BufEnter',
        'BufWinEnter',
        'CursorHold',
        'CursorHoldI',
        'BufWritePost',
        'FileChangedShellPost',
        'BufWritePost',
        'ModeChanged',
        'VimResume'
      },
      {
        callback = set_statusline_git_hunks,
        group = ag_statusline,
      }
    )

    ac(
      {
        'BufEnter',
        'BufWinEnter',
        'BufWritePost',
        'OptionSet',
        'VimResized',
        'WinEnter',
        'WinNew',
        'WinResized',
      },
      {
        callback = set_statusline_bname,
        group = ag_statusline,
      }
    )

    ac({ 'VimEnter', 'BufWinEnter', 'WinEnter', 'FocusGained' }, {
      group = ag_statusline,
      callback = function() wo.statusline = statusline(true) end
    })

    ac({ 'WinLeave', 'FocusLost' }, {
      group = ag_statusline,
      callback = function() wo.statusline = statusline(false) end
    })
  end,
  dependencies = {
    'AckslD/swenv.nvim',
    'lewis6991/gitsigns.nvim',
    'mason-org/mason.nvim',
  }
}

return M
