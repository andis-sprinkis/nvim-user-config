local sys_reqr = vim.g.sys_reqr

local M = {
  "_virt_inactive_stop_lsp",
  virtual = true,
  cond = sys_reqr.lsp_plugins,
  enabled = sys_reqr.lsp_plugins,
  event = "VeryLazy",
  config = function()
    -- Stopping LSP clients when inactive.
    -- Extracted from https://github.com/Zeioth/garbage-day.nvim (License: GPL-3).

    local excluded_lsp_clients = { "null-ls", "jdtls", "marksman", "lua_ls" }
    local lsp_start_focus_delay = 1000      -- ms
    local lsp_start_retries = 3             -- times
    local lsp_start_retries_timeout = 1000  -- ms
    local lsp_stop_grace_period = (60 * 15) -- seconds

    -- Start LSP clients for the current buffer.
    local function start_lsp()
      local lsp_start_timer = vim.uv.new_timer()
      local elapsed_retries = 0

      local start_lsp_timer_callback
      start_lsp_timer_callback = vim.schedule_wrap(function()
        if elapsed_retries >= lsp_start_retries then
          lsp_start_timer:stop()
          lsp_start_timer:close()
          return
        end

        vim.cmd(":LspStart")
        elapsed_retries = elapsed_retries + 1
        lsp_start_timer:start(lsp_start_retries_timeout, 0, start_lsp_timer_callback)
      end)

      lsp_start_timer:start(lsp_start_retries_timeout, 0, start_lsp_timer_callback)
    end

    -- Stop all LSP clients - including the ones in other buffers.
    local function stop_lsp()
      for _, client in pairs(vim.lsp.get_clients()) do
        if not vim.tbl_contains(excluded_lsp_clients, client.name) then
          vim.lsp.stop_client(client.id)
          client.rpc.terminate()
        end
      end
    end

    local focus_lost_timer = vim.uv.new_timer()
    local lsp_start_time = os.time()
    local focus_lost_current_time = 0
    local focus_lost_elapsed_time = 0
    local lsp_has_been_stopped = false
    local lsp_start_focus_delay_counting = false
    local lsp_stop_grace_period_exceeded = false

    vim.api.nvim_create_autocmd("FocusLost", {
      callback = function()
        lsp_start_focus_delay_counting = false

        focus_lost_timer:start(
          1000, 1000,
          vim.schedule_wrap(
            function()
              focus_lost_current_time = os.time()
              focus_lost_elapsed_time = focus_lost_current_time - lsp_start_time
              lsp_stop_grace_period_exceeded = focus_lost_elapsed_time >= lsp_stop_grace_period

              if lsp_stop_grace_period_exceeded and not lsp_has_been_stopped then
                focus_lost_timer:stop()
                stop_lsp()
                lsp_has_been_stopped = true
              end
            end
          )
        )
      end
    })

    vim.api.nvim_create_autocmd("FocusGained", {
      callback = function()
        lsp_start_focus_delay_counting = true

        vim.defer_fn(
          function()
            if not lsp_start_focus_delay_counting then return end
            if lsp_has_been_stopped then start_lsp() end

            lsp_start_time = os.time()
            focus_lost_current_time = 0
            focus_lost_elapsed_time = 0
            lsp_stop_grace_period_exceeded = false
            lsp_has_been_stopped = false
          end,
          lsp_start_focus_delay
        )
      end
    })
  end
}

return M
