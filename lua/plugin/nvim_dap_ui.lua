return function()
  local dap, dapui = require("dap"), require("dapui")

  dapui.setup({
    controls = {
      element = "repl",
      enabled = true,
      icons = {
        disconnect = "DC",
        pause      = "PA",
        play       = "PL",
        run_last   = "RL",
        step_back  = "BK",
        step_into  = "IN",
        step_out   = "OU",
        step_over  = "OV",
        terminate  = "TT"
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
        { id = "scopes",      size = 0.333 },
        { id = "breakpoints", size = 0.333 },
        { id = "stacks",      size = 0.333 },
        { id = "watches",     size = 0.333 },
      },
      position = "right",
      size = 40
    },
      {
        elements = {
          { id = "repl",    size = 0.5 },
          { id = "console", size = 0.5 },
        },
        position = "top",
        size = 10
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
end
