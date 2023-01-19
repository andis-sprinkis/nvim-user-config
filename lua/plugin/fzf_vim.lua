return function()
  local function show_files_with_git()
    if vim.fn.system('git rev-parse --git-dir') == '.git\n' then
      vim.cmd('GFiles --exclude-standard --others --cached')
      return
    end

    vim.cmd('Files')
  end

  vim.keymap.set('n', '<tab>', vim.g.sys_reqr.git_plugins and show_files_with_git or ':Files<cr>', { silent = true })
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
