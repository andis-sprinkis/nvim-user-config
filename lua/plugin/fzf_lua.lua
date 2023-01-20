return function()
  local exec = vim.g.exec
  local kms = vim.keymap.set

  local fzflua = require('fzf-lua')

  local previewer

  if exec.bat then
    previewer = 'bat'
  elseif exec.cat then
    previewer = 'cat'
  else
    previewer = 'builtin'
  end

  fzflua.setup({
    fzf_colors = {
      ['fg'] = { 'fg', 'CursorLine' },
      ['bg'] = { 'bg', 'Normal' },
      ['hl'] = { 'fg', 'Comment' },
      ['fg+'] = { 'fg', 'Normal' },
      ['bg+'] = { 'bg', 'CursorLine' },
      ['hl+'] = { 'fg', 'Statement' },
      ['info'] = { 'fg', 'PreProc' },
      ['prompt'] = { 'fg', 'Conditional' },
      ['pointer'] = { 'fg', 'Exception' },
      ['marker'] = { 'fg', 'Keyword' },
      ['spinner'] = { 'fg', 'Label' },
      ['header'] = { 'fg', 'Comment' },
      ['gutter'] = { 'bg', 'Normal' },
    },
    previewers = {
      cat = {
        cmd = 'cat',
        args = '',
      },
      bat = {
        cmd = 'bat',
        args = '--style=plain,changes --color always',
        theme = 'Visual Studio Dark+'
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
    winopts = {
      height = 0.9375,
      width = 0.9375,
      preview = {
        default = previewer,
        wrap = 'wrap',
        layout = 'vertical',
        vertical = 'up:60%',
      },
      hl = {
        border = 'FloatBorder'
      }
    }
  })

  local function show_files_with_git()
    if vim.fn.system('git rev-parse --git-dir') == '.git\n' then
      fzflua.git_files()
      return
    end

    fzflua.files()
  end

  kms('n', '<tab>', vim.g.sys_reqr.git_plugins and show_files_with_git or fzflua.files, { silent = true })
  kms('n', '<s-tab>', fzflua.files, { silent = true })
  kms('n', '<leader>e', function() fzflua.grep({ search = '' }) end, { silent = true })
end
