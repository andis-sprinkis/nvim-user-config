return function()
  local colorscheme_vscode = require('vscode')
  colorscheme_vscode.setup({
    italic_comments = true,
  })
  colorscheme_vscode.load()
end
