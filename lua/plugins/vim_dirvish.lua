local km = vim.keymap.set
local ac = vim.api.nvim_create_autocmd

local M = {
  'https://github.com/justinmk/vim-dirvish',
  branch = 'master',
  commit = 'ad478b4ac86484edc525bfc5379f261204dfbf4c',
  config = function()
    vim.g.dirvish_mode = ':sort i | sort ,^.*[^/]$, ri'

    vim.keymap.del('n', '-')

    km('n', '<leader>-', '<Plug>(dirvish_up)', { desc = "Show file directory (vim-dirvish)" })
    km('n', '<leader>c', function() vim.cmd.Dirvish(vim.fn.getcwd()) end,
      { desc = "Go to current working directory (vim-dirvish)", silent = true, nowait = true })

    ac(
      'FileType',
      {
        pattern = 'dirvish',
        callback = function()
          -- Workaround for https://github.com/justinmk/vim-dirvish/issues/257
          vim.opt_local.listchars = vim.opt.listchars:get()
          vim.opt_local.listchars:remove('precedes')

          km('n', '=', ':call dirvish#open("edit", 0)<CR>',
            { desc = "Open file at cursor (vim-dirvish)", silent = true, nowait = true, buffer = true })

          km('n', '-', '<Plug>(dirvish_up)',
            { desc = "Go up a directory (vim-dirvish)", silent = true, nowait = true, buffer = true })

          km('n', '/', '/\\c\\ze[^/]*[/]\\=$<Home><Right><Right>',
            { desc = "Search forward (vim-dirvish)", buffer = true })

          km('n', '?', '?\\c\\ze[^/]*[/]\\=$<Home><Right><Right>',
            { desc = "Search backward (vim-dirvish)", buffer = true })
        end,
        desc = "TODO DESC (user)"
      }
    )

    local has_stdin = false

    ac(
      'StdinReadPre',
      {
        callback = function()
          has_stdin = true
        end,
        desc = "TODO DESC (user)"
      }
    )

    ac(
      'UIEnter',
      {
        callback = function()
          if has_stdin or vim.fn.argc() > 0 or vim.tbl_contains(vim.v.argv, '+Man!') then return end

          vim.cmd.Dirvish()
        end,
        desc = "TODO DESC (user)"
      }
    )
  end,
  lazy = false,
  priority = 900
}

return M
