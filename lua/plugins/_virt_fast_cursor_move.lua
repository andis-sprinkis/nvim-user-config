local M = {
  "_virt_fast_cursor_move",
  virtual = true,
  config = function()
    -- Accelerates movement of h, j, k, l keys
    -- Adapted from https://github.com/xiyaowong/fast-cursor-move.nvim (license: MIT).

    local fn = vim.fn
    local km = vim.keymap.set

    local accel_v = { 4, 8, 16, 24, 32, 48, 64, 96, 128, 156, 172 }
    local accel_h = { 4, 8, 16, 24, 32, 48, 64, 96, 128, 156, 172 }

    local prev_key
    local prev_time = 0
    local move_count = 0

    local function mv(key, key_remap, key_accel)
      if fn.reg_recording() ~= "" or fn.reg_executing() ~= "" or vim.v.count > 0 then
        return key_remap
      end

      if key == prev_key then
        local current_time = vim.loop.hrtime()
        local elapsed_time = (current_time - prev_time) / 1e6

        prev_time = current_time
        move_count = elapsed_time > 150 and 0 or move_count + 1
      else
        prev_time = 0
        move_count = 0
        prev_key = key
      end

      for idx, count in ipairs(key_accel) do
        if move_count < count then return idx .. key_remap end
      end

      return #key_accel .. key_remap
    end

    km({ "n", "v" }, 'h', function() return mv('h', 'h', accel_h) end, { expr = true })
    km({ "n", "v" }, 'j', function() return mv('j', 'gj', accel_v) end, { expr = true })
    km({ "n", "v" }, 'k', function() return mv('k', 'gk', accel_v) end, { expr = true })
    km({ "n", "v" }, 'l', function() return mv('l', 'l', accel_h) end, { expr = true })
    km({ "n", "v" }, '<Left>', function() return mv('<Left>', 'g<Left>', accel_h) end, { expr = true })
    km({ "n", "v" }, '<Down>', function() return mv('<Down>', 'g<Down>', accel_v) end, { expr = true })
    km({ "n", "v" }, '<Up>', function() return mv('<Up>', 'g<Up>', accel_v) end, { expr = true })
    km({ "n", "v" }, '<Right>', function() return mv('<Right>', '<Right>', accel_h) end, { expr = true })
  end,
  keys = {
    { "h",       mode = { "n", "v" } },
    { "j",       mode = { "n", "v" } },
    { "k",       mode = { "n", "v" } },
    { "l",       mode = { "n", "v" } },
    { "<Left>",  mode = { "n", "v" } },
    { "<Down>",  mode = { "n", "v" } },
    { "<Up>",    mode = { "n", "v" } },
    { "<Right>", mode = { "n", "v" } },
  },
}

return M
