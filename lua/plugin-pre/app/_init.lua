vim.api.nvim_exec([[
  ru! get-title.vim
  ru! get-os.vim
  if exists('g:neoray') | ru! plugin-pre/app/neoray.vim | endif
  ru! plugin-pre/app/option.vim
]], false)
