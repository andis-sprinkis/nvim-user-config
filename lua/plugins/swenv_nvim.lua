local M = {
  'AckslD/swenv.nvim',
  config = function()
    require('swenv').setup({
      venvs_path = vim.fn.expand('~/.local/share/virtualenvs'),
      post_set_venv = function() vim.cmd.LspRestart() end
    })

    vim.api.nvim_create_user_command(
      'PythonSelectVenv',
      require('swenv.api').pick_venv,
      {}
    )
  end,
  dependencies = {
    'mason-org/mason.nvim'
  },
  event = 'VeryLazy'
}

return M
