local M = {
  'https://github.com/tpope/vim-fugitive',
  config = function()
    local uc = vim.api.nvim_create_user_command

    local ucmd = function(cmd)
      return function(opt_ucmd) vim.cmd(cmd .. ' ' .. opt_ucmd.args) end
    end

    local opt_cmd = { nargs = '?' }

    uc('Gc', ucmd 'G commit', opt_cmd)
    uc('Gcm', ucmd 'G commit -m', opt_cmd)
    uc('Gca', ucmd('G commit --amend'), opt_cmd)
    uc('Gcan', ucmd('G commit --amend --no-edit'), opt_cmd)
    uc('Gd', ucmd('G diff'), opt_cmd)
    uc('Gl', ucmd('G log'), opt_cmd)
    uc('Gpl', ucmd('G pull'), opt_cmd)
    uc('Gps', ucmd('G push'), opt_cmd)
    uc('Gs', ucmd('G status'), opt_cmd)
    uc('Gt', ucmd('G checkout'), opt_cmd)
  end,
  event = { "CmdlineEnter" }
}

return M
