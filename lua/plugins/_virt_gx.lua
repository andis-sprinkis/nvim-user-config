local M = {
  "_virt_gx",
  virtual = true,
  config = function()
    local km = vim.keymap.set
    local fn = vim.fn
    local uv = vim.uv

    local mime_for_editor = {
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

    local function open_uri(uri)
      local isFilePath = true

      local status = {
        err = false,
        uri_input = uri,
        uri_attempted = nil,
        message = nil
      }

      if uri:sub(1, 7) == 'file://' then
        local cmd_uname_output = fn.system({ 'uname', '-n' })

        if (vim.v.shell_error ~= 0) then
          status.err = true
          status.message = '"uname -n" exited with code ' .. vim.v.shell_error

          return status
        end

        uri = uri:gsub('^file://localhost/', '', 1)
        uri = uri:gsub('^file://' .. fn.trim(cmd_uname_output) .. '/', '', 1)
        uri = uri:gsub('^file://', '', 1)
        uri = uri:gsub('#.*', '', 1)
        uri = uri:gsub('?.*', '', 1)
        uri = uri:gsub('%%([a-f0-9A-F][a-f0-9A-F])', function(x) return string.char(tonumber(x, 16)) end)
      elseif uri:match('^[%l%u%d]+://') then
        isFilePath = false
      end

      if isFilePath then
        -- TODO: try the current working dir if the file-relative dir fails ?
        local fp_abs
        local fp_abs_file_relative
        local fp_abs_cwd_relative

        local is_aboslute = true

        if uri:sub(1, 1) ~= '/' then
          local current_file_dir = fn.expand('%:p:h')
          uri = current_file_dir .. '/' .. uri
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

        local cmd_mime_output = fn.system({ 'file', '--mime-type', '--brief', uri })

        if (vim.v.shell_error ~= 0) then
          status.err = true
          status.message = '"file --mime-type --brief" exited with code ' .. vim.v.shell_error
          status.uri_attempted = uri

          return status
        end

        local mime = fn.trim(cmd_mime_output)

        for _, pat in ipairs(mime_for_editor) do
          if string.match(mime, pat) then
            vim.cmd.e(uri)
            status.uri_attempted = uri
            return status
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

    local desc = 'Opens filepath or URI under cursor with the system handler (user)'

    km(
      'n',
      'gx',
      function()
        for _, uri in ipairs(require('vim.ui')._get_urls()) do
          local status = open_uri(uri)

          if status.err then
            vim.notify(status.message .. ' (' .. status.uri_attempted .. ')', vim.log.levels.ERROR)
          else
            vim.notify('Open: ' .. status.uri_attempted, vim.log.levels.INFO)
          end
        end
      end,
      { desc = desc }
    )

    km(
      'x',
      'gx',
      function()
        local lines = fn.getregion(fn.getpos('.'), fn.getpos('v'), { type = fn.mode() })

        -- Trim whitespace on each line and concatenate lines.
        local uri = table.concat(vim.iter(lines):map(vim.trim):totable())

        local status = open_uri(uri)

        if status.err then vim.notify(status.message, vim.log.levels.ERROR) end
      end,
      { desc = desc }
    )
  end,
  keys = {
    { "gx", mode = { "n", "x" } },
  }
}

return M
