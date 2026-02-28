local km = vim.keymap.set

local kmd = { "n", "o", "x" }

local M = {
  "_virt_fast_cursor_move",
  virtual = true,
  config = function()
    -- Accelerates movement of h, j, k, l, arrows and word-motion keys keys.
    -- Adapted from https://github.com/xiyaowong/fast-cursor-move.nvim (license: MIT).

    local fn = vim.fn

    local accel_v = { 5, 15, 45, 60, 90, 120, 160, 190, 220, 250, 280, 320 }
    local accel_h = { 5, 30, 60, 90, 120, 160, 190, 220, 250, 280, 320, 350 }

    local prev_key
    local prev_time = 0
    local move_count = 0

    local function mv(key, accel)
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

      for idx, count in ipairs(accel) do
        if move_count < count then return idx .. key end
      end

      return #accel .. key
    end

    local kopt = { expr = true }

    km(kmd, 'h', function() return mv('h', accel_h) end, kopt)
    km(kmd, 'j', function() return mv('j', accel_v) end, kopt)
    km(kmd, 'k', function() return mv('k', accel_v) end, kopt)
    km(kmd, 'l', function() return mv('l', accel_h) end, kopt)

    km(kmd, '<Left>', function() return mv('<Left>', accel_h) end, kopt)
    km(kmd, '<Down>', function() return mv('<Down>', accel_v) end, kopt)
    km(kmd, '<Up>', function() return mv('<Up>', accel_v) end, kopt)
    km(kmd, '<Right>', function() return mv('<Right>', accel_h) end, kopt)

    km(kmd, '-', function() return mv('-', accel_h) end, kopt)

    km(kmd, '=', function() return mv('+', accel_h) end, kopt)
    km(kmd, '+', '=')

    -- km(kmd, 'w', function() return mv("w", accel_h) end, kopt)
    km(kmd, 'w', function() return mv("<cmd>lua require('spider').motion('w')<CR>", accel_h) end, kopt)

    km(kmd, 'W', function() return mv('W', accel_h) end, kopt)

    -- km(kmd, 'e', function() return mv('e', accel_h) end, kopt)
    km(kmd, 'e', function() return mv("<cmd>lua require('spider').motion('e')<CR>", accel_h) end, kopt)

    km(kmd, 'E', function() return mv('E', accel_h) end, kopt)

    -- km(kmd, 'b', function() return mv('b', accel_h) end, kopt)
    km(kmd, 'b', function() return mv("<cmd>lua require('spider').motion('b')<CR>", accel_h) end, kopt)

    km(kmd, 'B', function() return mv('B', accel_h) end, kopt)
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
    { "w",       mode = kmd },
    { "W",       mode = kmd },
    { "e",       mode = kmd },
    { "E",       mode = kmd },
    { "b",       mode = kmd },
    { "B",       mode = kmd },
  },
  dependencies = {
    "https://github.com/chrisgrieser/nvim-spider",
    config = function()
      km(kmd, "ge", "<cmd>lua require('spider').motion('ge')<CR>")
    end
  }
}

return M
