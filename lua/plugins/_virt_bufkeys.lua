local M = {
  "_virt_bufkeys",
  virtual = true,
  config = function()
    -- Cycling between the last n viewed buffers using key maps.
    -- Adapted from https://github.com/mihaifm/bufstop (license: MIT).

    local api = vim.api
    local fn = vim.fn
    local tbl_filter = vim.tbl_filter
    local ac = api.nvim_create_autocmd
    local ag = api.nvim_create_augroup
    local km = vim.keymap.set

    local buf_hist = {}

    ac(
      "BufWinEnter",
      {
        group = ag("Bufkeys", {}),
        callback = function()
          local curr_buf_id = api.nvim_get_current_buf()

          buf_hist = tbl_filter(function(buf_id) return buf_id ~= curr_buf_id end, buf_hist)

          table.insert(buf_hist, 1, curr_buf_id)
        end,
      }
    )

    local filter_buf_exists_listed = function(buf_id)
      return fn.bufexists(buf_id) == 1 and fn.buflisted(buf_id) == 1
    end

    local function switch_to_buf_idx(buf_idx)
      if vim.api.nvim_win_get_config(0).relative ~= "" then return end

      buf_hist = tbl_filter(filter_buf_exists_listed, buf_hist)

      local len_hist = #buf_hist

      if len_hist <= 1 then return end

      vim.cmd.b(buf_hist[buf_idx <= len_hist and buf_idx or len_hist])
    end

    local idx_keys = { "<F2>", "<F3>", "<F4>", "<F5>", "<F6>", "<F7>", "<F8>", "<F9>", "<F10>", "<F11>", "<F12>" }

    for idx, key in ipairs(idx_keys) do
      km(
        'n',
        key,
        function() switch_to_buf_idx(idx + 1) end,
        { desc = 'Cycle between the last ' .. idx + 1 .. ' buffers (_virt_bufkeys)' }
      )
    end

    km(
      'n',
      '<F1>',
      function() switch_to_buf_idx(2) end,
      { desc = 'Cycle between the last 2 buffers (_virt_bufkeys)' }
    )

    km(
      'n',
      '<leader><leader>',
      function() switch_to_buf_idx(2) end,
      { desc = 'Cycle between the last 2 buffers (_virt_bufkeys)' }
    )
    --
  end
}

return M
