local M = {
  "_virt_quickfix_loclist_fmt",
  enabled = true,
  virtual = true,
  filetype = 'qf',
  config = function()
    -- Formatting of quickfix and location list for better readability.
    -- Adapted from https://github.com/yorickpeterse/nvim-pqf (license: MPL-2.0).
    local api = vim.api
    local fn = vim.fn

    local type_mapping = {
      E = { text = 'E', hl = 'DiagnosticSignError' },
      W = { text = 'W', hl = 'DiagnosticSignWarn' },
      I = { text = 'I', hl = 'DiagnosticSignInfo' },
      N = { text = 'H', hl = 'DiagnosticSignHint' },
    }

    local namespace = api.nvim_create_namespace('quickfix_loclist_fmt')

    function _G.quickfix_loclist_fmt(info)
      local list = info.quickfix == 1
          and fn.getqflist({ id = info.id, items = 1, qfbufnr = 1 })
          or fn.getloclist(info.winid, { id = info.id, items = 1, qfbufnr = 1 })

      local lines = {}
      local pad_to = 0
      local items = {}
      local show_sign = false

      -- If we're adding a new list rather than appending to an existing one, we
      -- need to clear existing highlights.
      if info.start_idx == 1 then api.nvim_buf_clear_namespace(list.qfbufnr, namespace, 0, -1) end

      local raw_items = list.items

      for i = info.start_idx, info.end_idx do
        local raw = raw_items[i]

        if raw then
          local item = {
            type = raw.type,
            text = raw.text,
            location = '',
            path_size = 0,
            line_col_size = 0,
            index = i,
          }

          if type_mapping[item.type] then show_sign = true end

          if raw.bufnr > 0 then
            item.location = fn.fnamemodify(fn.bufname(raw.bufnr), ':p:.')
            item.path_size = #item.location
          end

          if raw.lnum and raw.lnum > 0 then
            local lnum = raw.lnum

            if raw.end_lnum and raw.end_lnum > 0 and raw.end_lnum ~= lnum then
              lnum = lnum .. '-' .. raw.end_lnum
            end

            item.location = #item.location > 0 and item.location .. ' ' .. lnum or tostring(lnum)

            -- Column numbers without line numbers make no sense, and may confuse
            -- the user into thinking they are actually line numbers.
            if raw.col and raw.col > 0 then
              local col = raw.col

              if raw.end_col and raw.end_col > 0 and raw.end_col ~= col then
                col = col .. '-' .. raw.end_col
              end

              item.location = item.location .. ':' .. col
            end

            item.line_col_size = #item.location - item.path_size
          end

          local size = fn.strwidth(item.location)

          if size > pad_to then pad_to = size end

          table.insert(items, item)
        end
      end

      local highlights = {}

      for _, item in ipairs(items) do
        local line_idx = item.index - 1

        -- Quickfix items only support singe-line messages, and show newlines as
        -- funny characters. In addition, many language servers (e.g.
        -- rust-analyzer) produce super noisy multi-line messages where only the
        -- first line is relevant.
        --
        -- To handle this, we only include the first line of the message in the
        -- quickfix line.
        local text = vim.split(item.text, '\n')[1]
        local location = item.location

        text = fn.trim(text)

        if text ~= '' and pad_to > 0 then
          local loc_pad = location

          for i = fn.strwidth(location), pad_to do loc_pad = loc_pad .. ' ' end

          location = loc_pad
        end

        local sign_conf = type_mapping[item.type]
        local sign = ' '
        local sign_hl = nil

        if sign_conf then
          sign = sign_conf.text
          sign_hl = sign_conf.hl
        end

        local prefix = show_sign and sign .. ' ' or ''
        local line = prefix .. location .. text

        -- If a line is completely empty, Vim uses the default format, which
        -- involves inserting `|| `. To prevent this from happening we'll just
        -- insert an empty space instead.
        if line == '' then line = ' ' end

        if show_sign and sign_hl then
          table.insert(
            highlights,
            { group = sign_hl, line = line_idx, col = 0, end_col = #sign }
          )
        end

        if item.path_size > 0 then
          table.insert(
            highlights,
            { group = 'Directory', line = line_idx, col = #prefix, end_col = #prefix + item.path_size }
          )
        end

        if item.line_col_size > 0 then
          local col_start = #prefix + item.path_size

          table.insert(
            highlights,
            { group = 'Number', line = line_idx, col = col_start, end_col = col_start + item.line_col_size }
          )
        end

        table.insert(lines, line)
      end

      -- Applying highlights has to be deferred, otherwise they won't apply to the
      -- lines inserted into the quickfix window.
      vim.schedule(
        function()
          for _, hl in ipairs(highlights) do
            vim.highlight.range(list.qfbufnr, namespace, hl.group, { hl.line, hl.col }, { hl.line, hl.end_col })
          end
        end
      )

      return lines
    end

    vim.o.quickfixtextfunc = "v:lua._G.quickfix_loclist_fmt"
    --
  end
}

return M
