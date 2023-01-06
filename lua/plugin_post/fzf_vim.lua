return function()
  if not vim.g.sys_reqr.git_plugins then
    vim.keymap.set('n', '<tab>', ':Files<cr>', { silent = true })
  else
    local function showFiles()
      if vim.fn.system('git rev-parse --git-dir') == '.git\n' then
        vim.cmd('GFiles --exclude-standard --others --cached')
      else
        vim.cmd('Files')
      end
    end

    vim.keymap.set('n', '<tab>', function() showFiles() end, { silent = true })
  end

  vim.keymap.set('n', '<s-tab>', ':Files<cr>', { silent = true })
  vim.keymap.set('n', '<leader>e', ':Rg<cr>', { silent = true })

  if vim.fn.executable('bat') == 1 then
    vim.env.BAT_THEME = 'Visual Studio Dark+'
    vim.env.BAT_STYLE = 'plain'
    vim.env.FZF_DEFAULT_OPTS = '--tabstop=2 --cycle --color=dark --layout=reverse-list --preview \'bat --color=always --line-range=:300 {}\' --preview-window=up,62%,wrap'
  else
    vim.env.FZF_DEFAULT_OPTS = '--tabstop=2 --cycle --color=dark --layout=reverse-list --preview-window=up,62%,wrap'
  end

  vim.g.fzf_layout = { window = { width = 0.9, height = 0.95, relative = 'editor', yoffset = 0.5 } }
end
