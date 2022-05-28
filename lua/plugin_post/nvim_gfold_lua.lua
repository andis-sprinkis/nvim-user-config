return function()
  require('gfold').setup({
    picker = {
      -- what to do when selecting a repo
      -- by default changes cwd
      on_select = require('gfold.actions').change_cwd,
    },
  })
  vim.cmd([[command! Gfold execute "lua require('gfold').pick_repo()"]])
end
