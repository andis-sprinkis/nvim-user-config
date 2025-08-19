local M = {
  "lf",
  virtual = true,
  config = function()
    -- Opening the lf file manager in a floating terminal window.
    -- Adapted from https://github.com/is0n/fm-nvim (license: GPL-3.0)

    local api = vim.api
    local uc = api.nvim_create_user_command
    local ac = api.nvim_create_autocmd
    local ag = api.nvim_create_augroup
    local fn = vim.fn
    local cmd = vim.cmd

    if fn.executable('lf') == 1 then
      uc(
        "Lf",
        function(option)
          local buf = api.nvim_create_buf(false, true)

          local win = api.nvim_open_win(
            buf,
            true,
            {
              style = "minimal",
              relative = "editor",
              width = api.nvim_get_option_value("columns", {}),
              height = api.nvim_get_option_value("lines", {}) - 1,
              col = 0,
              row = 0
            }
          )

          ac(
            "VimResized",
            {
              group = ag("LfWindow", {}),
              buffer = buf,
              callback = function()
                api.nvim_win_set_width(win, api.nvim_get_option_value("columns", {}))

                api.nvim_win_set_height(win, api.nvim_get_option_value("lines", {}) - 1)
              end,
            }
          )

          local cache_sel_path = fn.stdpath("cache") .. "/lf_sel_path"

          fn.jobstart(
            "lf -selection-path " .. cache_sel_path .. " " .. (option.fargs[1] or "."),
            {
              term = true,
              on_exit = function()
                api.nvim_win_close(win, true)
                api.nvim_buf_delete(buf, { force = true })

                if io.open(cache_sel_path, "r") ~= nil then
                  for line in io.lines(cache_sel_path) do
                    cmd("edit " .. fn.fnameescape(line))
                  end

                  io.close(io.open(cache_sel_path, "r"))
                  os.remove(cache_sel_path)
                end

                cmd.checktime()
              end,
            }
          )

          cmd.startinsert()

          api.nvim_set_option_value('winhl', "Normal:Normal", { win = win })
        end,
        {
          nargs = "?",
          complete = "dir"
        }
      )
    end
    --
  end,
  cmd = { "Lf" }
}

return M
