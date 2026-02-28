local kmd = { "n", "v" }

local M = {
  "_virt_fast_cursor_move",
  virtual = true,
  config = function()
    -- Accelerates movement of h, j, k, l and arrow keys.
    -- Adapted from https://github.com/xiyaowong/fast-cursor-move.nvim (license: MIT).

    local fn = vim.fn
    local km = vim.keymap.set

    local key_accel_v = { 5, 15, 45, 60, 90, 120, 160, 190, 220 }
    local key_accel_h = { 5, 30, 60, 90, 120, 160, 190, 220, 250 }

    local prev_key
    local prev_time = 0
    local move_count = 0

    local function mv(key, key_accel)
      if fn.reg_recording() ~= "" or fn.reg_executing() ~= "" or vim.v.count > 0 then
        return key
      end

      if key == prev_key then
        local current_time = vim.loop.hrtime()
        move_count = (current_time - prev_time) / 1e6 > 150 and 0 or move_count + 1
        prev_time = current_time
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

    local kopt = { expr = true }

    km(kmd, 'h', function() return mv('h', key_accel_h) end, kopt)
    km(kmd, 'j', function() return mv('j', key_accel_v) end, kopt)
    km(kmd, 'k', function() return mv('k', key_accel_v) end, kopt)
    km(kmd, 'l', function() return mv('l', key_accel_h) end, kopt)

    km(kmd, '<Left>', function() return mv('<Left>', key_accel_h) end, kopt)
    km(kmd, '<Down>', function() return mv('<Down>', key_accel_v) end, kopt)
    km(kmd, '<Up>', function() return mv('<Up>', key_accel_v) end, kopt)
    km(kmd, '<Right>', function() return mv('<Right>', key_accel_h) end, kopt)

    km(kmd, '-', function() return mv('-', key_accel_h) end, kopt)
    km(kmd, '=', function() return mv('+', key_accel_h) end, kopt)
    km(kmd, '+', '=')

    -- km(kmd, 'w', function() return mv('w', key_accel_h) end, kopt)
    -- km(kmd, 'W', function() return mv('W', key_accel_h) end, kopt)
    -- km(kmd, 'e', function() return mv('e', key_accel_h) end, kopt)
    -- km(kmd, 'E', function() return mv('E', key_accel_h) end, kopt)
    -- km(kmd, 'b', function() return mv('b', key_accel_h) end, kopt)
    -- km(kmd, 'B', function() return mv('B', key_accel_h) end, kopt)
    --
  end,
  keys = {
    { "h",       mode = kmd },
    { "j",       mode = kmd },
    { "k",       mode = kmd },
    { "l",       mode = kmd },
    { "<Left>",  mode = kmd },
    { "<Down>",  mode = kmd },
    { "<Up>",    mode = kmd },
    { "<Right>", mode = kmd },
    { "-",       mode = kmd },
    { "=",       mode = kmd },
    { "+",       mode = kmd },
    -- { "w",       mode = kmd },
    -- { "W",       mode = kmd },
    -- { "e",       mode = kmd },
    -- { "E",       mode = kmd },
    -- { "b",       mode = kmd },
    -- { "B",       mode = kmd },
  },
}

return M
