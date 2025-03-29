local M = {
  'Mofiqul/vscode.nvim',
  config = function()
    local colorscheme_vscode = require('vscode')
    local c = require('vscode.colors').get_colors()
    local isDark = vim.o.background == 'dark'

    colorscheme_vscode.setup({
      italic_comments = true,
      -- color_overrides = {
      --   vscLineNumber = '#FFFFFF',
      -- },
      group_overrides = {
        -- todo: use color_overrides instead
        NormalFloat = { bg = c.vscTabOutside },
        Pmenu = { fg = isDark and c.vscTabOutside or 'none', bg = c.vscPopupBack }
      }
    })
    colorscheme_vscode.load()
  end,
  lazy = false,
  priority = 1000
}

return M
