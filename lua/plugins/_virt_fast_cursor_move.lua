local M = {
  "_virt_fast_cursor_move",
  virtual = true,
  config = function()
    -- Accelerates movement of h, j, k, l keys
    -- Adapted from https://github.com/xiyaowong/fast-cursor-move.nvim (license: MIT).

    local fn = vim.fn

    local accel_v = { 7, 14, 20, 26, 31, 36, 40 }
    local accel_h = { 10, 15, 20 }

    local accel = {
      h = accel_h,
      l = accel_h,
      j = accel_v,
      k = accel_v,
    }

    local chars = {
      l = "l",
      h = "h",
      j = "gj",
      k = "gk",
    }

    local prev_dir
    local prev_time = 0
    local move_count = 0

    local function move(dir)
      if fn.reg_recording() ~= "" or fn.reg_executing() ~= "" or vim.v.count > 0 then
        return chars[dir]
      end

      if dir == prev_dir then
        local current_time = vim.loop.hrtime()
        local elapsed_time = (current_time - prev_time) / 1e6

        prev_time = current_time
        move_count = elapsed_time > 150 and 0 or move_count + 1
      else
        prev_time = 0
        move_count = 0
        prev_dir = dir
      end

      local key_accel = accel[dir]

      for idx, count in ipairs(key_accel) do
        if move_count < count then return idx .. chars[dir] end
      end

      return #key_accel .. chars[dir]
    end

    vim.keymap.set({ "n", "v" }, 'h', function() return move('h') end, { expr = true })
    vim.keymap.set({ "n", "v" }, 'j', function() return move('j') end, { expr = true })
    vim.keymap.set({ "n", "v" }, 'k', function() return move('k') end, { expr = true })
    vim.keymap.set({ "n", "v" }, 'l', function() return move('l') end, { expr = true })
  end,
  keys = {
    { "h", mode = { "n", "v" } },
    { "j", mode = { "n", "v" } },
    { "k", mode = { "n", "v" } },
    { "l", mode = { "n", "v" } },
  },
}

return M
