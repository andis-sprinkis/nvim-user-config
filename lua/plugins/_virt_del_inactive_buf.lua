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
    local ignoreFt = { "lazy", "mason" }

    local arg_buf_del = { force = false, unload = false }
    local arg_buf_listed = { buflisted = 1 }

    local function checkInactiveBuf()
      local listedBufs = fn.getbufinfo(arg_buf_listed)

      if #listedBufs == 0 then return end

      for _, buf in pairs(listedBufs) do
        -- Visible?
        if buf.hidden == 0 and buf.loaded == 1 then goto continue end
        local bufnr = buf.bufnr
        local arg_bufnr = { buf = bufnr }
        -- Unsaved?
        if get_opt("modified", arg_bufnr) then goto continue end
        -- Special type?
        if get_opt("buftype", arg_bufnr) ~= "" then goto continue end
        -- Used recently?
        if os.time() - buf.lastused < inactiveAfterMins * 60 then goto continue end
        -- Ignored filetype?
        if vim.tbl_contains(ignoreFt, get_opt("filetype", arg_bufnr)) then goto continue end
        -- Alternate-file?
        if buf.name == fn.expand("#:p") then goto continue end
        -- In QuickFix list?
        if vim.iter(vim.fn.getqflist())
            :map(function(e) return e.bufnr end)
            :find(buf.bufnr) then
          goto continue
        end

        api.nvim_buf_delete(bufnr, arg_buf_del)

        ::continue::
      end
    end

    local timer = vim.uv.new_timer()

    if timer == nil then return end

    timer:start(inactiveAfterMins * 60000, checkIntervalSecs * 1000, vim.schedule_wrap(checkInactiveBuf))
    --
  end
}

return M
