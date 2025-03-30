local M = {
  'Mofiqul/vscode.nvim',
  config = function()
    local colorscheme_vscode = require('vscode')
    local c = require('vscode.colors').get_colors()
    local isDark = vim.o.background == 'dark'

    colorscheme_vscode.setup({
      italic_comments = true,
      color_overrides = {
        vscPopupBack = '#272727',
      },
    })
    colorscheme_vscode.load()
  end,
  lazy = false,
  priority = 1000
}

return M
