local M = {
  'Mofiqul/vscode.nvim',
  config = function()
    local colorscheme_vscode = require('vscode')
    colorscheme_vscode.setup({
      italic_comments = true
    })
    colorscheme_vscode.load()
  end,
  lazy = false,
  priority = 1000
}

return M
