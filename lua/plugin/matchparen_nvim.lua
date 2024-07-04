local M = {
  'monkoose/matchparen.nvim',
  config = function ()
    require('matchparen').setup({
      on_startup = false
    })

    local ag = vim.api.nvim_create_augroup
    local ac = vim.api.nvim_create_autocmd

    local ag_matchparen_nvim_cfg = ag('matchparen_nvim_cfg', { clear = true })

    ac({ 'BufRead' }, {
      group = ag_matchparen_nvim_cfg,
      callback = function()
        if vim.b.large_file_buf then
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
