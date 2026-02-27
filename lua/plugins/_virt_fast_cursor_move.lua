local M = {
  "_virt_fast_cursor_move",
  virtual = true,
  config = function()
    -- Accelerates movement of h, j, k, l and arrow keys.
    -- Adapted from https://github.com/xiyaowong/fast-cursor-move.nvim (license: MIT).

    local fn = vim.fn
    local km = vim.keymap.set

    local key_accel = { 2, 30, 60, 90, 120, 160, 190 }

    local prev_key
    local prev_time = 0
    local move_count = 0

    local function mv(key)
      if fn.reg_recording() ~= "" or fn.reg_executing() ~= "" or vim.v.count > 0 then
        return key
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
        if move_count < count then return idx .. key end
      end

      return #key_accel .. key
    end

    km({ "n", "v" }, 'h', function() return mv('h') end, { expr = true })
    km({ "n", "v" }, 'j', function() return mv('j') end, { expr = true })
    km({ "n", "v" }, 'k', function() return mv('k') end, { expr = true })
    km({ "n", "v" }, 'l', function() return mv('l') end, { expr = true })
    km({ "n", "v" }, '<Left>', function() return mv('<Left>') end, { expr = true })
    km({ "n", "v" }, '<Down>', function() return mv('<Down>') end, { expr = true })
    km({ "n", "v" }, '<Up>', function() return mv('<Up>') end, { expr = true })
    km({ "n", "v" }, '<Right>', function() return mv('<Right>') end, { expr = true })
    --
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
