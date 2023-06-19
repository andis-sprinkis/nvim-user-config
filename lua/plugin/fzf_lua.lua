return function()
  local exec = vim.g.exec
  local km = vim.keymap.set

  local fzflua = require('fzf-lua')

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
        args = '--number',
      },
      bat = {
        cmd = 'bat',
        args = '--style=plain,numbers,header-filename,changes --color=always',
        theme = 'Visual Studio Dark+'
      },
      man = {
        cmd = 'man %s | col -bx',
      }
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
      fullscreen = true,
      border = 'none',
      preview = {
        default = (exec.bat and 'bat') or (exec.cat and 'cat') or 'builtin',
        wrap = 'wrap',
        layout = 'vertial',
        vertical = 'up:60%',
        border = 'noborder'
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

  km('n', '<tab>', show_files_with_git)
  km('n', '<s-tab>', fzflua.files)
  km('n', '<leader>e', function() fzflua.grep({ search = '' }) end)
  km('n', '<leader>z', fzflua.builtin)
  km('n', '<leader>h', fzflua.help_tags)
end
