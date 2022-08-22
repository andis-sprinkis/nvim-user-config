return function()
  if vim.g.sys_reqr['treesitter'] then
    require('Comment').setup {
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
    }
  else
    require('Comment').setup()
  end
end
