local g = vim.g
local sys_reqr = g.sys_reqr

local M = {
  'ibhagwan/fzf-lua',
  cond = sys_reqr.fzf_lua,
  enabled = sys_reqr.fzf_lua,
  config = function()
    local exec = g.exec
    local km = vim.keymap.set

    local fzflua = require('fzf-lua')

    fzflua.setup({
      fzf_colors = true,
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
          layout = 'vertical',
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

    km('n', '<tab>', show_files_with_git, { desc = 'Dunno (fzf-lua)' })
    km('n', '<s-tab>', fzflua.files, { desc = 'Dunno (fzf-lua)' })
    km('n', '<leader>e', function() fzflua.grep({ search = '' }) end, { desc = 'Dunno (fzf-lua)' })
    km('n', '<leader>z', fzflua.builtin, { desc = 'Dunno (fzf-lua)' })
    km('n', '<leader>h', fzflua.help_tags, { desc = 'Dunno (fzf-lua)' })
  end,
  event = { "CmdlineEnter" },
  keys = {
    { "<tab>",     mode = { "n" } },
    { "<s-tab>",   mode = { "n" } },
    { "<leader>e", mode = { "n" } },
    { "<leader>z", mode = { "n" } },
    { "<leader>h", mode = { "n" } },
  },
  dependencies = {
    'stevearc/dressing.nvim',
  },
}

return M
