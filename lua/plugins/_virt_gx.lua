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

    local function create_uris_list(input)
      local uris_list = {}
      local hostname = uv.os_gethostname()

      for _, uri in ipairs(input) do
        if uri == '' then goto continue end

        local isUrl = uri:match('^[%l%u%d]+://')
        local isFurl = uri:sub(1, 7) == 'file://'
        local isFp = (not isUrl) or isFurl

        if isFurl then
          uri = uri:gsub('^file://localhost/', '/', 1)
          uri = uri:gsub('^file://' .. hostname .. '/', '/', 1)
          uri = uri:gsub('^file://', '', 1)
          uri = uri:gsub('#.*', '', 1)
          uri = uri:gsub('?.*', '', 1)
          uri = uri:gsub('%%([a-f0-9A-F][a-f0-9A-F])', function(x) return string.char(tonumber(x, 16)) end)

          if uri == '' then goto continue end
        end

        local variants

        if isFp then
          variants = {
            uri,
            fn.expand('%:p:h') .. '/' .. uri,
            vim.fn.getcwd() .. '/' .. uri,
          }
        else
          variants = { uri }
        end

        table.insert(uris_list, { variants = variants, isFp = isFp })

        ::continue::
      end

      return uris_list
    end

    local function open_variant(variant, isFp, with_vim_ui_open)
      if isFp then
        local cmd_readlinkf_output = fn.system({ 'readlink', '-f', variant })

        if (vim.v.shell_error ~= 0) then return false end

        variant = fn.trim(cmd_readlinkf_output)

        local success, err, err_name = uv.fs_stat(variant)

        if not success then return false end

        if not with_vim_ui_open then
          local cmd_mime_output = fn.system({ 'file', '--mime-type', '--brief', variant })

          if (vim.v.shell_error ~= 0) then return false end

          local mime = fn.trim(cmd_mime_output)

          for _, pat in ipairs(editor_mime) do
            if string.match(mime, pat) then
              print('Open: ' .. variant)
              vim.cmd.e(variant)
              return true
            end
          end
        end
      end

      print('Open: ' .. variant)
      vim.ui.open(variant)

      return true
    end

    local function open_uris(uris, with_vim_ui_open)
      local opened = {}

      for _, uri in ipairs(create_uris_list(uris)) do
        for _, variant in ipairs(uri.variants) do
          if open_variant(variant, uri.isFp, with_vim_ui_open) then
            table.insert(opened, variant)
            goto continue
          end
        end
        :: continue ::
      end

      if #opened > 0 then print('Open: ' .. table.concat(opened, ', ')) else print('Nothing to open') end
    end

    local function open_uris_n(with_vim_ui_open)
      local uris = require('vim.ui')._get_urls()
      open_uris(uris, with_vim_ui_open)
    end

    local function open_uris_x(with_vim_ui_open)
      local lines = vim.fn.getregion(vim.fn.getpos('.'), vim.fn.getpos('v'), { type = vim.fn.mode() })
      local uris = vim.iter(lines):map(vim.trim):totable()
      open_uris(uris, with_vim_ui_open)
    end

    local km_opt_normal = { desc = 'Opens filepath or URI under cursor (user)' }
    local km_opt_system = { desc = 'Opens filepath or URI under cursor with the system handler (user)' }

    km('n', 'gx', open_uris_n, km_opt_normal)
    km('x', 'gx', open_uris_x, km_opt_normal)
    km('n', 'gX', function() open_uris_n(true) end, km_opt_system)
    km('x', 'gX', function() open_uris_x(true) end, km_opt_system)
  end,
  keys = {
    { "gx", mode = { "n", "x" } },
    { "gX", mode = { "n", "x" } },
  }
}

return M
