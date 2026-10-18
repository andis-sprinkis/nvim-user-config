local M = {
  'https://github.com/monkoose/matchparen.nvim',
  branch = 'main',
  commit = '87df7d1459c3376aaf5a67d116f0b293cc65ad13',
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
