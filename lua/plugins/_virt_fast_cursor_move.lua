local M = {
  "_virt_fast_cursor_move",
  virtual = true,
  enabled = true,
  config = function()
    -- Accelerates movement of h, j, k, l keys
    -- Adapted from https://github.com/xiyaowong/fast-cursor-move.nvim (license: MIT).

    local fn = vim.fn

    local accel_vert = { 7, 14, 20, 26, 31, 36, 40 }
    local accel_hor = { 10, 15, 20 }

    local accel = {
      h = accel_hor,
      l = accel_hor,
      j = accel_vert,
      k = accel_vert,
    }

    local prev_dir
    local prev_time = 0
    local move_count = 0

    local get_move_step = function(dir)
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
        if move_count < count then
          return idx
        end
      end

      return #key_accel
    end

    local move_chars = {
      l = "l",
      h = "h",
      j = "gj",
      k = "gk",
    }

    local function move(dir)
      if fn.reg_recording() ~= "" or fn.reg_executing() ~= "" or vim.v.count > 0 then
        return move_chars[dir]
      end

      return get_move_step(dir) .. move_chars[dir]
    end

    vim.keymap.set({ "n", "v" }, 'h', function() return move('h') end, { expr = true })
    vim.keymap.set({ "n", "v" }, 'j', function() return move('j') end, { expr = true })
    vim.keymap.set({ "n", "v" }, 'k', function() return move('k') end, { expr = true })
    vim.keymap.set({ "n", "v" }, 'l', function() return move('l') end, { expr = true })

    -- vim.defer_fn(setup, 500)
  end,
  keys = {
    { "h", mode = { "n", "v" } },
    { "j", mode = { "n", "v" } },
    { "k", mode = { "n", "v" } },
    { "l", mode = { "n", "v" } },
  },
}

return M
