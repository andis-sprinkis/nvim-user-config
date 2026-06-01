local M = {
  'https://github.com/NMAC427/guess-indent.nvim',
  branch = 'main',
  commit = '84a4987ff36798c2fc1169cbaff67960aed9776f',
  config = function()
    require('guess-indent').setup {
      filetype_exclude = {
        "dirvish",
        "fugitive",
        "help",
        "lazy",
        "man",
        "prompt",
        "spectre_panel",
      }
    }
  end,
  lazy = false,
  priority = 900
}

return M
