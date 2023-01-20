return function()
  local kms = vim.keymap.set
  local env = vim.env
  local g = vim.g
  local fn = vim.fn
  local cmd = vim.cmd

  local function show_files_with_git()
    if fn.system('git rev-parse --git-dir') == '.git\n' then
      cmd('GFiles --exclude-standard --others --cached')
      return
    end

    cmd('Files')
  end

  kms('n', '<tab>', g.sys_reqr.git_plugins and show_files_with_git or ':Files<cr>', { silent = true })
  kms('n', '<s-tab>', ':Files<cr>', { silent = true })
  kms('n', '<leader>e', ':Rg<cr>', { silent = true })

  if fn.executable('bat') == 1 then
    env.BAT_THEME = 'Visual Studio Dark+'
    env.BAT_STYLE = 'plain'
    env.FZF_DEFAULT_OPTS = '--tabstop=2 --cycle --color=dark --layout=reverse-list --preview \'bat --color=always --line-range=:300 {}\' --preview-window=up,62%,wrap'
  else
    env.FZF_DEFAULT_OPTS = '--tabstop=2 --cycle --color=dark --layout=reverse-list --preview-window=up,62%,wrap'
  end

  g.fzf_layout = { window = { width = 0.9, height = 0.95, relative = 'editor', yoffset = 0.5 } }
end
