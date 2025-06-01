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
        "nofile",
        "prompt",
        "terminal",
      }
    }
  end,
  lazy = false,
  priority = 900
}

return M
