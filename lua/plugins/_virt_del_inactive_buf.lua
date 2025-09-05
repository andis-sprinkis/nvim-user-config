local M = {
  "_virt_del_inactive_buf",
  virtual = true,
  event = 'BufHidden',
  config = function()
    -- Deleting inactive buffers after some time.
    -- Apadted from https://github.com/chrisgrieser/nvim-early-retirement (license: MIT).
    local api = vim.api
    local fn = vim.fn
    local get_opt = api.nvim_get_option_value

    local inactiveAfterMins = 20
    local checkIntervalSecs = 30
    local ignoreFt = { "lazy" }

    local function checkInactiveBuf()
      local openBufs = fn.getbufinfo({ buflisted = 1 })

      if #openBufs == 0 then return end

      for _, buf in pairs(openBufs) do
        -- Is buffer visible?
        if buf.hidden == 0 and buf.loaded == 1 then goto continue end
        -- Is buffer unsaved?
        if get_opt("modified", { buf = buf.bufnr }) then goto continue end
        -- Is buffer special type?
        if get_opt("buftype", { buf = buf.bufnr }) ~= "" then goto continue end
        -- Is buffer used recently?
        if os.time() - buf.lastused < inactiveAfterMins * 60 then goto continue end
        -- Is buffer ignored filetype?
        if vim.tbl_contains(ignoreFt, get_opt("filetype", { buf = buf.bufnr })) then goto continue end
        -- Is buffer alternate-file?
        if buf.name == fn.expand("#:p") then goto continue end

        api.nvim_buf_delete(buf.bufnr, { force = false, unload = false })

        ::continue::
      end
    end

    local timer = vim.uv.new_timer()

    if timer ~= nil then
      timer:start(inactiveAfterMins * 60000, checkIntervalSecs * 1000, vim.schedule_wrap(checkInactiveBuf))
    end
    --
  end
}

return M
