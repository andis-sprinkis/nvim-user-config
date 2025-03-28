local M = {
  "olimorris/codecompanion.nvim",
  config = function()
    vim.env["CODECOMPANION_TOKEN_PATH"] = vim.fn.expand("~/.config")
  end,
  opts = {
    -- https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
    strategies = {
      chat = { adapter = "copilot" },
      inline = { adapter = "copilot" },
    },
    opts = {
      -- log_level = "DEBUG",
    },
  },
  dependencies = {
    "hrsh7th/nvim-cmp",
    -- 'saghen/blink.cmp',
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- "zbirenbaum/copilot.lua"
    -- "github/copilot.vim"
  }
}

return M
