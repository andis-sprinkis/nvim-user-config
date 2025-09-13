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
        .. '%( ' .. "%{exists('b:statl_git')?b:statl_git:''}" .. '%)'
        .. '%( ' .. "%{exists('b:statl_pyvenv')?b:statl_pyvenv:''}" .. '%)'
        .. '%( ' .. "%{exists('b:statl_lsp')?b:statl_lsp:''}" .. '%)'
        .. ' %)'
        .. '%#StatusLine'

    local p2 =
        '#'
        .. '%='
        .. '%( ' .. "%{exists('w:statl_bname')?w:statl_bname:''}" .. ' %)'
        .. '%=%#StatusLineNC#'
        .. '%( '
        .. '%(' .. "%{exists('b:statl_largef')?b:statl_largef:''}" .. '%h%q%r%m' .. ' %)'
        .. '%(' .. "%{exists('b:statl_mimeft')?b:statl_mimeft:''}" .. ' %)'
        .. '%(' .. "%{exists('b:statl_encfmt')?b:statl_encfmt:''}" .. ' %)'
        .. '%3c %2l/%-L %3p%%'
        .. ' %)'

    local function fmt_statl(focus) return p1 .. (focus and '' or 'NC') .. p2 end

    local largef_msg = '[Size >' .. g.maxfsize_kb .. 'K]'

    local function set_statl_largef()
      if vim.bo.buftype ~= '' and vim.bo.buftype ~= 'help' then
        b.statl_largef = nil
        return
      end

      b.statl_largef = b.largef and largef_msg or ''
    end

    local ft_ignore_encfmt = { 'lazy', 'mason', 'man', 'help' }

    local function set_statl_encfmt()
      if vim.bo.buftype ~= '' then
        b.statl_encfmt = nil
        return
      end

      if vim.tbl_contains(ft_ignore_encfmt, bo.ft) then
        b.statl_encfmt = nil
        return
      end

      local enc = bo.fileencoding and bo.fileencoding or o.encoding
      local fmt = bo.fileformat

      local msg = {}

      if enc ~= 'utf-8' then
        msg[#msg + 1] = enc
      end

      if fmt ~= 'unix' then
        msg[#msg + 1] = '[' .. fmt .. ']'
      end

      if #msg > 0 then
        b.statl_encfmt = table.concat(msg, ' ')
        return
      end

      b.statl_encfmt = nil
    end

    local function set_statl_mimeft()
      if bo.filetype and bo.filetype ~= '' then
        b.statl_mimeft = bo.filetype
        return
      end

      if bo.buftype ~= '' then
        b.statl_mimeft = nil
        return
      end

      local fname = fn.expand('%:p')

      if (fname == '') or (not vim.uv.fs_stat(fname)) then
        b.statl_mimeft = nil
        return
      end

      local cmd_mime_output = fn.system('file --mime-type --brief "' .. fname .. '"')

      if (vim.v.shell_error ~= 0) then
        b.statl_mimeft = nil
        return
      end

      b.statl_mimeft = fn.trim(cmd_mime_output)
    end

    local function set_statl_pyvenv()
      if sys_reqr.swenv then
        local status_mod, mod = pcall(require, "swenv.api")
        if (status_mod) then
          local venv = mod.get_current_venv()
          b.statl_pyvenv = venv and "venv:" .. venv.name or nil
        end
      end
    end

    local ft_ignore_git = { 'lazy', 'mason', 'man', 'help' }

    local function set_statl_git()
      if vim.tbl_contains(ft_ignore_git, bo.ft) then
        b.statl_git = nil
        return
      end

      if b.gitsigns_status then
        b.statl_git = b.gitsigns_status == '' and b.gitsigns_head or
            b.gitsigns_head .. ' ' .. b.gitsigns_status
        return
      end

      b.statl_git = g.gitsigns_head and g.gitsigns_head or nil
    end

    local function set_statl_bname()
      for _, win in ipairs(api.nvim_list_wins()) do
        local max_width = math.floor(api.nvim_win_get_width(win) * 0.5)
        local name = fn.fnamemodify(api.nvim_buf_get_name(fn.getwininfo(win)[1].bufnr), ':.')
        if #name > max_width then name = '...' .. name:sub(-max_width) end
        w[win].statl_bname = name
      end
    end

    local ft_ignore_lsp = { 'dirvish', 'futigive', 'lazy', 'mason', 'man', 'help', '' }
    local lsp_severity = { { 'ERROR', 'E' }, { 'WARN', 'W' }, { 'INFO', 'I' }, { 'HINT', 'H' } }

    local function set_statl_lsp()
      if bo.buftype ~= '' then
        b.statl_lsp = nil
        return
      end

      if vim.tbl_contains(ft_ignore_lsp, bo.ft) then
        b.statl_lsp = nil
        return
      end

      if vim.tbl_isempty(lsp.get_clients({ bufnr = 0 })) then
        b.statl_lsp = nil
        return
      end

      local msg = {}

      for _, ty in ipairs(lsp_severity) do
        local n = diagnostic.get(0, { severity = ty[1] })
        if #n > 0 then
          table.insert(msg, ty[2] .. ':' .. #n)
        end
      end

      if #msg > 0 then
        b.statl_lsp = table.concat(msg, ' ')
        return
      end

      b.statl_lsp = nil
    end

    local ag_statl = ag('statl', {})

    ac(
      {
        'BufReadPre',
        'BufWritePost',
        'FileChangedShellPost'
      },
      {
        callback = set_statl_largef,
        group = ag_statl,
      }
    )

    ac(
      {
        'BufWinEnter',
        'FileType'
      },
      {
        callback = set_statl_mimeft,
        group = ag_statl,
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
        callback = set_statl_encfmt,
        group = ag_statl,
      }
    )

    ac(
      {
        'BufEnter',
        'BufWinEnter'
      },
      {
        callback = set_statl_pyvenv,
        group = ag_statl,
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
        callback = set_statl_lsp,
        group = ag_statl,
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
        callback = set_statl_git,
        group = ag_statl,
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
        callback = set_statl_bname,
        group = ag_statl,
      }
    )

    ac({ 'BufWinEnter', 'WinEnter', 'FocusGained' }, {
      group = ag_statl,
      callback = function() wo.statusline = fmt_statl(true) end
    })

    ac({ 'WinLeave', 'FocusLost' }, {
      group = ag_statl,
      callback = function() wo.statusline = fmt_statl(false) end
    })
  end
}
