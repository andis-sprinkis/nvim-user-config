local previewer = 'cat'

if vim.fn.executable('bat') == 1 then previewer = 'bat' end

function IsInGitDir()
  return vim.fn.system('git rev-parse --git-dir') == '.git\n'
end

function ShowFiles(withGit)
  if (withGit) then
    require('fzf-lua').git_files({ previewer = previewer })
  else
    require('fzf-lua').files({ previewer = previewer })
  end
end

function ShowGrep()
  require('fzf-lua').live_grep({ previewer = previewer })
end

if not vim.g.plug_requirement.git_plugins then
  vim.api.nvim_set_keymap('n', '<tab>', ':lua ShowFiles(false)<cr>', { noremap = true, silent = true })
else
  vim.api.nvim_set_keymap('n', '<tab>', ':lua ShowFiles(IsInGitDir())<cr>', { noremap = true, silent = true })
end

vim.api.nvim_set_keymap('n', '<s-tab>', ':lua ShowFiles(false)<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>e', ':lua ShowGrep()<cr>', { noremap = true, silent = true })
