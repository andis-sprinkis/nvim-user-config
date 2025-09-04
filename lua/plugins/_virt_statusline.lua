return {
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

    local p1 =
        '%#StatusLineNC#'
        .. '%('
        .. '%( ' .. "%{exists('b:statusline_git_hunks')?b:statusline_git_hunks:''}" .. '%)'
        .. '%( ' .. "%{exists('b:statusline_py_swenv')?b:statusline_py_swenv:''}" .. '%)'
        .. '%( ' .. "%{exists('b:statusline_lsp_status')?b:statusline_lsp_status:''}" .. '%)'
        .. ' %)'

    local p2 =
        '%='
        .. '%(' .. "%{exists('w:statusline_bname')?w:statusline_bname:''}" .. ' %)'
        .. '%=%#StatusLineNC#'
        .. '%( '
        .. '%(' .. "%{exists('b:statusline_large_file_buf')?b:statusline_large_file_buf:''}" .. '%h%q%r%m' .. ' %)'
        .. '%(' .. "%{exists('b:statusline_mime_ft')?b:statusline_mime_ft:''}" .. ' %)'
        .. '%(' .. "%{exists('b:statusline_fenc_ffmat')?b:statusline_fenc_ffmat:''}" .. ' %)'
        .. '%3c %2l/%-L %3p%%'
        .. ' %)'

    local function statusline(active)
      return p1 .. (active and '%#StatusLine#' or '%#StatusLineNC#') .. p2
    end

    local large_file_buf_fmat = '[Size >' .. tostring(g.max_file_size_kb) .. 'K]'

    local function set_statusline_large_file_buf()
      if vim.bo.buftype == 'terminal' then
        b.statusline_large_file_buf = nil
        return
      end

      b.statusline_large_file_buf = b.large_file_buf and large_file_buf_fmat or ''
    end

    local ft_ignore_fenc_ffmat = { 'man', 'help' }

    local function set_statusline_fenc_ffmat()
      if vim.bo.buftype == 'terminal' then
        b.statusline_fenc_ffmat = nil
        return
      end

      for _, ft in ipairs(ft_ignore_fenc_ffmat) do
        if bo.ft == ft then
          b.statusline_fenc_ffmat = nil
          return
        end
      end

      local fenc = bo.fileencoding and bo.fileencoding or o.encoding
      local ffmat = bo.fileformat

      local status = {}

      if fenc ~= 'utf-8' then
        status[#status + 1] = fenc
      end

      if ffmat ~= 'unix' then
        status[#status + 1] = '[' .. ffmat .. ']'
      end

      if #status > 0 then
        b.statusline_fenc_ffmat = table.concat(status, ' ')
        return
      end

      b.statusline_fenc_ffmat = nil
    end

    local function set_statusline_mime_ft()
      if bo.filetype and bo.filetype ~= '' then
        b.statusline_mime_ft = bo.filetype
        return
      end

      local fname = fn.expand('%:p')

      if (fname == '') or (not vim.uv.fs_stat(fname)) then
        b.statusline_mime_ft = nil
        return
      end

      local cmd_mime_output = fn.system('file --mime-type --brief "' .. fname .. '"')

      if (vim.v.shell_error ~= 0) then
        b.statusline_mime_ft = nil
        return
      end

      b.statusline_mime_ft = fn.trim(cmd_mime_output)
    end

    local function set_statusline_py_swenv()
      if sys_reqr.swenv then
        local swenv_api = require("swenv.api")
        local venv = swenv_api.get_current_venv()

        b.statusline_py_swenv = venv and "venv:" .. venv.name or nil
      end
    end

    local ft_ignore_git_hunks = { 'man', 'help' }

    local function set_statusline_git_hunks()
      for _, ft in ipairs(ft_ignore_git_hunks) do
        if bo.ft == ft then
          b.statusline_git_hunks = nil
          return
        end
      end

      if b.gitsigns_status then
        b.statusline_git_hunks = b.gitsigns_status == '' and b.gitsigns_head or
            b.gitsigns_head .. ' ' .. b.gitsigns_status
        return
      end

      b.statusline_git_hunks = g.gitsigns_head and g.gitsigns_head or nil
    end

    local function set_statusline_bname()
      for _, win in ipairs(api.nvim_list_wins()) do
        local max_width = math.floor(api.nvim_win_get_width(win) * 0.5)
        local name = fn.fnamemodify(api.nvim_buf_get_name(fn.getwininfo(win)[1].bufnr), ':.')
        if #name > max_width then name = '...' .. name:sub(-max_width) end
        w[win].statusline_bname = name
      end
    end

    local lsp_severity = { { 'WARN', 'W' }, { 'ERROR', 'E' }, { 'INFO', 'I' }, { 'HINT', 'H' } }

    local ft_ignore_lsp_status = { 'dirvish', 'futigive', 'lazy', 'man', 'help', '' }

    local function set_statusline_lsp_status()
      for _, ft in ipairs(ft_ignore_lsp_status) do
        if bo.ft == ft then
          b.statusline_lsp_status = nil
          return
        end
      end

      if bo.buftype == 'terminal' then
        b.statusline_lsp_status = nil
        return
      end

      if vim.tbl_isempty(lsp.get_clients({ bufnr = 0 })) then
        b.statusline_lsp_status = nil
        return
      end

      local status = {}

      for _, ty in ipairs(lsp_severity) do
        local n = diagnostic.get(0, { severity = ty[1] })
        if #n > 0 then
          table.insert(status, ty[2] .. ':' .. #n)
        end
      end

      if #status > 0 then
        b.statusline_lsp_status = table.concat(status, ' ')
        return
      end

      b.statusline_lsp_status = nil
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
        'BufWinEnter',
        'FileType'
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
