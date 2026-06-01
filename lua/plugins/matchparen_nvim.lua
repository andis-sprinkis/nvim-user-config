local M = {
  'https://github.com/monkoose/matchparen.nvim',
  branch = 'main',
  commit = 'd48619803d5e2aacc207b46ce6acfb23bcdb9b1d',
  config = function()
    require("matchparen").setup()

    local ag = vim.api.nvim_create_augroup
    local ac = vim.api.nvim_create_autocmd

    local ag_matchparen_nvim_cfg = ag('matchparen_nvim_cfg', {})

    ac({ 'BufRead' }, {
      group = ag_matchparen_nvim_cfg,
      callback = function()
        if vim.b.largef then
          vim.cmd("MatchParenDisable")
        else
          vim.cmd("MatchParenEnable")
        end
      end
    })
  end,
  event = 'VeryLazy'
}

return M
