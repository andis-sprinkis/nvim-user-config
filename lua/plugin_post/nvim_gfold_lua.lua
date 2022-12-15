return function()
  require('gfold').setup({
    picker = {
      -- what to do when selecting a repo
      -- by default changes cwd
      on_select = function (repo, idx)
        require('gfold.actions').change_cwd(repo, idx)
        if repo then
          vim.cmd("split")
          vim.cmd("edit " .. repo.path)
        end
      end,
    },
  })

  vim.cmd([[command! Gfold execute "lua require('gfold').pick_repo()"]])
end
