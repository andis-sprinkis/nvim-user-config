vim.api.nvim_exec([[
ru! plugin/autoload-plug.vim
ru! plugin/plug.vim
if g:requirementCocNvim | ru! plugin/coc.vim | endif
]], false)
