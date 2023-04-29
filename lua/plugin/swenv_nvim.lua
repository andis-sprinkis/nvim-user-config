return function()
  local swenv_api = require('swenv.api')

  require('swenv').setup({
    -- Should return a list of tables with a `name` and a `path` entry each.
    -- Gets the argument `venvs_path` set below.
    -- By default just lists the entries in `venvs_path`.
    get_venvs = function(venvs_path) return swenv_api.get_venvs(venvs_path) end,
    -- Path passed to `get_venvs`.
    venvs_path = vim.fn.expand('~/.local/share/virtualenv'),
    -- Something to do after setting an environment
    post_set_venv = nil,
  })

  vim.api.nvim_create_user_command(
    'PythonSelectVenv',
    swenv_api.pick_venv,
    { bang = true }
  )
end
