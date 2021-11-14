local previewer = 'cat'
if vim.fn.executable('bat') == 1 then
  previewer = 'bat'
elseif vim.fn.executable('cat') == 1 then
  previewer = 'cat'
else
  previewer = 'builtin'
end

require'fzf-lua'.setup({
  -- fzf_colors = {
  --   ["fg"] = { "fg", "CursorLine" },
  --   ["bg"] = { "bg", "Normal" },
  --   ["hl"] = { "fg", "Comment" },
  --   ["fg+"] = { "fg", "Normal" },
  --   ["bg+"] = { "bg", "CursorLine" },
  --   ["hl+"] = { "fg", "Statement" },
  --   ["info"] = { "fg", "PreProc" },
  --   ["prompt"] = { "fg", "Conditional" },
  --   ["pointer"] = { "fg", "Exception" },
  --   ["marker"] = { "fg", "Keyword" },
  --   ["spinner"] = { "fg", "Label" },
  --   ["header"] = { "fg", "Comment" },
  --   ["gutter"] = { "bg", "Normal" },
  -- },
  previewers = {
    cat = {
      cmd = "cat",
      args = "",
    },
    bat = {
      cmd = "bat",
      args = "--style=plain,changes --color always",
      theme = 'ansi'
    },
  },
  files = {
    git_icons = false
  },
  git = {
    files = {
      git_icons = false
    },
  },
  grep = {
    git_icons = false
  },
  winopts =  {
    height = 0.955,
    width = 0.935,
    preview = {
      default = previewer,
      wrap = 'wrap',
      layout = 'vertical',
      vertical = 'up:60%',
    },
  }
})

function IsInGitDir()
  return vim.fn.system('git rev-parse --git-dir') == '.git\n'
end

function ShowFiles(withGit)
  if (withGit) then
    require('fzf-lua').git_files()
  else
    require('fzf-lua').files()
  end
end

function ShowGrep()
  require('fzf-lua').grep({ search = '' })
end

if vim.g.plug_requirement.git_plugins then
  vim.api.nvim_set_keymap('n', '<tab>', ':lua ShowFiles(IsInGitDir())<cr>', { noremap = true, silent = true })
else
  vim.api.nvim_set_keymap('n', '<tab>', ':lua ShowFiles(false)<cr>', { noremap = true, silent = true })
end

vim.api.nvim_set_keymap('n', '<s-tab>', ':lua ShowFiles(false)<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>e', ':lua ShowGrep()<cr>', { noremap = true, silent = true })
