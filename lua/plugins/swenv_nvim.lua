local M = {
  'https://github.com/AckslD/swenv.nvim',
  config = function()
    require('swenv').setup({
      venvs_path = vim.fn.expand('~/.local/share/virtualenvs'),
      post_set_venv = function() vim.cmd.LspRestart() end
    })

    local api = vim.api

    local swenv_api = require('swenv.api')

    api.nvim_create_user_command(
      'PythonSelectVenv',
      swenv_api.pick_venv,
      {}
    )

    api.nvim_create_autocmd(
      {
        'BufEnter',
        'BufWinEnter'
      },
      {
        callback = function()
          local venv = swenv_api.get_current_venv()
          vim.b.statl_pyvenv = venv and "venv:" .. venv.name or nil
        end,
        group = api.nvim_create_augroup('swenv_user', {}),
      }
    )
  end,
  dependencies = {
    'https://github.com/mason-org/mason.nvim'
  },
  event = 'VeryLazy'
}

return M
