if not vim.g.plug_reqr.git_plugins then
  vim.api.nvim_set_keymap('n', '<tab>', ':Files<cr>', { noremap = true, silent = true })
else
  function ShowGitFiles()
    if vim.fn.system('git rev-parse --git-dir') == '.git\n' then
      vim.cmd('GFiles --exclude-standard --others --cached')
    else
      vim.cmd('Files')
    end
  end

  vim.api.nvim_set_keymap('n', '<tab>', ':lua ShowGitFiles()<cr>', { noremap = true, silent = true })
end

vim.api.nvim_set_keymap('n', '<s-tab>', ':Files<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>e', ':Rg<cr>', { noremap = true, silent = true })

if vim.fn.executable('bat') == 1 then
  vim.env.BAT_THEME = 'ansi'
  vim.env.BAT_STYLE = 'plain'
  vim.env.FZF_DEFAULT_OPTS = '--tabstop=2 --cycle --color=dark --layout=reverse-list --preview \'bat --color=always --line-range=:300 {}\' --preview-window=up,62%,wrap'
else
  vim.env.FZF_DEFAULT_OPTS = '--tabstop=2 --cycle --color=dark --layout=reverse-list --preview-window=up,62%,wrap'
end

vim.g.fzf_layout = { window = { width = 0.9, height = 0.95, relative = 'editor', yoffset = 0.5 } }
