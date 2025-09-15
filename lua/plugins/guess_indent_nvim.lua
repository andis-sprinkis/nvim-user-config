local M = {
  'NMAC427/guess-indent.nvim',
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
