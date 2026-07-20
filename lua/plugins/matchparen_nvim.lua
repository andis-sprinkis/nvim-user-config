local M = {
  'https://github.com/monkoose/matchparen.nvim',
  branch = 'main',
  commit = '75398158ea5a4cee4f0cbbeefdbf8fb1c3343e28',
  config = function()
    require("matchparen").setup()

    vim.api.nvim_create_autocmd(
      'BufRead',
      {
        callback = function()
          if vim.b.largef then
            vim.cmd("MatchParenDisable")
          else
            vim.cmd("MatchParenEnable")
          end
        end,
        desc = "TODO DESC (user)"
      }
    )
  end,
  event = 'VeryLazy'
}

return M
