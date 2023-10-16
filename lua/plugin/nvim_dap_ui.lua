local M = {
  'rcarriga/nvim-dap-ui',
  config = function()
    local api = vim.api
    local ag = api.nvim_create_augroup
    local ac = api.nvim_create_autocmd
    local cuc = api.nvim_create_user_command
    local dap, dapui = require("dap"), require("dapui")

    dapui.setup({
      controls = {
        element = "repl",
        enabled = true,
        icons = {
          disconnect = "DCN",
          pause      = "PAU",
          play       = "PLA",
          run_last   = "RLT",
          step_back  = "SBK",
          step_into  = "SIN",
          step_out   = "SOU",
          step_over  = "SOV",
          terminate  = "TMT"
        }
      },
      element_mappings = {},
      expand_lines = true,
      floating = {
        border = "single",
        mappings = {
          close = { "q", "<Esc>" }
        }
      },
      force_buffers = true,
      icons = {
        collapsed = ">",
        current_frame = ">>",
        expanded = "<"
      },
      layouts = { {
        elements = {
          { id = "repl",        size = 0.25 },
          { id = "breakpoints", size = 0.25 },
          { id = "stacks",      size = 0.25 },
          { id = "watches",     size = 0.25 },
        },
        position = "right",
        size = 0.3333333333
      },
        {
          elements = {
            { id = "console", size = 0.5 },
            { id = "scopes",  size = 0.5 },
          },
          position = "top",
          size = 0.36
        }
      },
      mappings = {
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t"
      },
      render = {
        indent = 1,
        max_value_lines = 100
      }
    })

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    -- dap.listeners.before.event_terminated["dapui_config"] = function()
    --   dapui.close()
    -- end
    -- dap.listeners.before.event_exited["dapui_config"] = function()
    --   dapui.close()
    -- end

    local dapui_panel_buf = {
      ['dap-repl'] = true,
      ['dap-terminal'] = true,
      dapui_breakpoints = true,
      dapui_console = true,
      dapui_scopes = true,
      dapui_stacks = true,
      dapui_watches = true,
    }

    local ag_dapui_cfg = ag('dapui_cfg', {})

    ac(
      'FileType',
      {
        group = ag_dapui_cfg,
        pattern = {
          'dap-repl',
          'dap-terminal',
          'dapui_breakpoints',
          'dapui_console',
          'dapui_scopes',
          'dapui_stacks',
          'dapui_watches',
        },
        callback = function()
          vim.opt_local.cursorline = false
        end
      }
    )

    ac(
      'QuitPre',
      {
        group = ag_dapui_cfg,
        callback = function()
          if (dapui_panel_buf[vim.bo.filetype]) then
            dapui.close()
          end
        end
      }
    )

    cuc('DapUIClose', dapui.close, {})
    cuc('DapUIOpen', function() dapui.open({ reset = true }) end, {})
    cuc('DapUIToggle', function() dapui.toggle({ reset = true }) end, {})
  end,
  cmd = { 'DapUIOpen', 'DapUIToggle' },
  dependencies = {
    'mfussenegger/nvim-dap',
  },
}

return M
