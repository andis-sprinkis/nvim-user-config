local M = {
  'https://github.com/monkoose/matchparen.nvim',
  branch = 'main',
  commit = '7a0928f528db7a01807ea32d50d0e4425d629188',
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
