return function()
  require('swenv').setup({
    -- Path passed to `get_venvs`.
    venvs_path = vim.fn.expand('~/.local/share/virtualenvs'),
    -- Should return a list of tables with a `name` and a `path` entry each.
    -- Gets the argument `venvs_path` set below.
    -- By default just lists the entries in `venvs_path`.
    get_venvs = function(venvs_path) return require('swenv.api').get_venvs(venvs_path) end,
    -- Something to do after setting an environment
    post_set_venv = function() vim.cmd.LspRestart() end
  })

  vim.api.nvim_create_user_command(
    'PythonSelectVenv',
    require('swenv.api').pick_venv,
    { bang = true }
  )
end
