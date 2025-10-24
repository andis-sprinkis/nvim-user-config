return {
  "_virt_statusline",
  virtual = true,
  config = function()
    local api = vim.api
    local b = vim.b
    local w = vim.w
    local bo = vim.bo
    local fn = vim.fn
    local g = vim.g
    local o = vim.opt
    local wo = vim.wo
    local ac = api.nvim_create_autocmd
    local ag = api.nvim_create_augroup

    local p1 =
        '%#StatusLineNC#'
        .. '%('
        .. '%( ' .. "%{exists('b:statl_git')?b:statl_git:''}" .. '%)' --[[ plug.gitsigns_nvim ]]
        .. '%( ' .. "%{exists('b:statl_pyvenv')?b:statl_pyvenv:''}" .. '%)' --[[ plug.swenv_nvim ]]
        .. '%( ' .. "%{exists('b:statl_lsp')?b:statl_lsp:''}" .. '%)' --[[ plug.mason_nvim ]]
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

    local statl_focused = p1 .. p2
    local statl_unfocused = p1 .. 'NC' .. p2

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

      local cmd_mime_output = fn.system({ 'file', '--mime-type', '--brief', fname })

      if (vim.v.shell_error ~= 0) then
        b.statl_mimeft = nil
        return
      end

      b.statl_mimeft = fn.trim(cmd_mime_output)
    end

    local function set_statl_bname()
      for _, win in ipairs(api.nvim_list_wins()) do
        local max_width = math.floor(api.nvim_win_get_width(win) * 0.5)
        local name = fn.fnamemodify(api.nvim_buf_get_name(fn.getwininfo(win)[1].bufnr), ':.')
        if #name > max_width then name = '...' .. name:sub(-max_width) end
        w[win].statl_bname = name
      end
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
      callback = function() wo.statusline = statl_focused end
    })

    ac({ 'WinLeave', 'FocusLost' }, {
      group = ag_statl,
      callback = function() wo.statusline = statl_unfocused end
    })
  end
}
