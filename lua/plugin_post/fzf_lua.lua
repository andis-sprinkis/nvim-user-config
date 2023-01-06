return function()
  local previewer = 'cat'
  if vim.fn.executable('bat') == 1 then
    previewer = 'bat'
  elseif vim.fn.executable('cat') == 1 then
    previewer = 'cat'
  else
    previewer = 'builtin'
  end

  require 'fzf-lua'.setup({
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

  local function isInGitDir()
    return vim.fn.system('git rev-parse --git-dir') == '.git\n'
  end

  local function showFiles(withGit)
    if (withGit) then
      require('fzf-lua').git_files()

      return
    end

    require('fzf-lua').files()
  end

  if vim.g.sys_reqr.git_plugins then
    vim.keymap.set({ 'n' }, '<tab>', function() showFiles(isInGitDir()) end, { silent = true })
  else
    vim.keymap.set({ 'n' }, '<tab>', function() showFiles() end, { silent = true })
  end

  vim.keymap.set('n', '<s-tab>', function() showFiles() end, { silent = true })
  vim.keymap.set('n', '<leader>e', function() require('fzf-lua').grep({ search = '' }) end, { silent = true })
end
