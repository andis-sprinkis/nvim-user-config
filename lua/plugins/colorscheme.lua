local M = {
  'https://github.com/Mofiqul/vscode.nvim',
  branch = 'main',
  commit = 'aa1102a7e15195c9cca22730b09224a7f7745ba8',
  config = function()
    local colorscheme_vscode = require('vscode')

    colorscheme_vscode.setup({
      italic_comments = true,
      color_overrides = {
        -- TODO: dynamic override per light & dark theme
        vscPopupBack = '#272727',
      },
    })
    colorscheme_vscode.load()
  end,
  lazy = false,
  priority = 1000
}

return M
