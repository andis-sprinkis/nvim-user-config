local M = {
  "_virt_gx",
  virtual = true,
  config = function()
    local km = vim.keymap.set
    local fn = vim.fn
    local uv = vim.uv

    local editor_mime = {
      'text/*',
      'inode/directory',
      'inode/empty',
      'image/svg%+xml',
      'application/xml',
      'application/*json*',
      'application/xhtml*',
      'application/javascript',
      'application/x%-httpd%-php',
      'application/x%-wine%-extension%-ini',
      'application/x%-mswinurl',
      'application/x%-subrip',
      'application/x%-awk',
    }

    local function furl_to_fp(furl)
      furl = furl:gsub('^file://localhost/', '', 1)
      furl = furl:gsub('^file://' .. uv.os_gethostname() .. '/', '', 1)
      furl = furl:gsub('^file://', '', 1)
      furl = furl:gsub('#.*', '', 1)
      furl = furl:gsub('?.*', '', 1)
      furl = furl:gsub('%%([a-f0-9A-F][a-f0-9A-F])', function(x) return string.char(tonumber(x, 16)) end)

      return furl
    end

    local function open_uri(uri, with_vim_ui_open)
      local status = {
        err = false,
        uri_input = uri,
        uri_attempted = nil,
        message = nil
      }

      local isUrl = uri:match('^[%l%u%d]+://')
      local isFurl = uri:sub(1, 7) == 'file://'
      local isFp = (not isUrl) or isFurl

      uri = isFurl and furl_to_fp(uri) or uri

      if isFp then
        -- local fp_file_rel
        -- local fp_cwd_rel
        --
        -- local is_fp_aboslute = true

        if uri:sub(1, 1) ~= '/' then
          -- is_fp_aboslute = false

          local fp_currf_dir = fn.expand('%:p:h')
          -- local fp_cwd_dir = vim.fn.getcwd()

          -- fp_file_rel = fp_current_file_dir .. '/' .. uri
          -- fp_cwd_rel = fp_cwd_dir .. '/' .. uri

          uri = fp_currf_dir .. '/' .. uri
        end

        local cmd_readlinkf_output = fn.system({ 'readlink', '-f', uri })

        if (vim.v.shell_error ~= 0) then
          status.err = true
          status.message = '"readlink -f" exited with code ' .. vim.v.shell_error
          status.uri_attempted = uri

          return status
        end

        uri = fn.trim(cmd_readlinkf_output)

        local success, err, err_name = uv.fs_stat(uri)

        if not success then
          status.err = true
          status.message = err
          status.uri_attempted = uri

          return status
        end

        if not with_vim_ui_open then
          local cmd_mime_output = fn.system({ 'file', '--mime-type', '--brief', uri })

          if (vim.v.shell_error ~= 0) then
            status.err = true
            status.message = '"file --mime-type --brief" exited with code ' .. vim.v.shell_error
            status.uri_attempted = uri

            return status
          end

          local mime = fn.trim(cmd_mime_output)

          for _, pat in ipairs(editor_mime) do
            if string.match(mime, pat) then
              vim.cmd.e(uri)
              status.uri_attempted = uri
              return status
            end
          end
        end
      end

      local comm, err = vim.ui.open(uri)
      local rv = comm and comm:wait(1000) or nil

      if comm and rv and rv.code ~= 0 then
        status.err = true
        status.message = ('vim.ui.open: command %s (%d): %s'):format(
          (rv.code == 124 and 'timeout' or 'failed'),
          rv.code,
          vim.inspect(comm.cmd)
        )
        status.uri_attempted = uri

        return status
      end

      status.err = err ~= nil
      status.message = err
      status.uri_attempted = uri

      return status
    end

    local function open_n(with_vim_ui_open)
      for _, uri in ipairs(require('vim.ui')._get_urls()) do
        local status = open_uri(uri, with_vim_ui_open)

        if status.err then
          vim.notify(status.message .. ' (' .. status.uri_attempted .. ')', vim.log.levels.ERROR)
        else
          vim.notify('Open: ' .. status.uri_attempted, vim.log.levels.INFO)
        end
      end
    end

    local function open_x(with_vim_ui_open)
      for _, uri in ipairs(require('vim.ui')._get_urls()) do
        local status = open_uri(uri, with_vim_ui_open)

        if status.err then
          vim.notify(status.message .. ' (' .. status.uri_attempted .. ')', vim.log.levels.ERROR)
        else
          vim.notify('Open: ' .. status.uri_attempted, vim.log.levels.INFO)
        end
      end
    end

    local opt_x = { desc = 'Opens filepath or URI under cursor (user)' }
    km('n', 'gx', open_n, opt_x)
    km('x', 'gx', open_x, opt_x)

    local opt_X = { desc = 'Opens filepath or URI under cursor with the system handler (user)' }
    km('n', 'gX', function() open_n(true) end, opt_X)
    km('x', 'gX', function() open_x(true) end, opt_X)
  end,
  keys = {
    { "gx", mode = { "n", "x" } },
    { "gX", mode = { "n", "x" } },
  }
}

return M
