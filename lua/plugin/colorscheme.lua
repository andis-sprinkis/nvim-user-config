local M = {
  'Mofiqul/vscode.nvim',
  commit = '7331e8316d558e9b3f63b066e98029704f281e91',
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
