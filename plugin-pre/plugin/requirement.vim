lua <<EOF
if vim.fn.executable('git') == false then
  vim.g.nogitplugin = true
else
  if vim.g.nogitplugin == nil then 
    vim.g.nogitplugin = false 
  end
end

vim.g.requirementCocNvim = vim.fn.executable('node') and vim.fn.executable('yarn')
vim.g.requirementSudaVim = vim.fn.executable('sudo')
vim.g.requirementFzfInstall = vim.g.os == 'Windows' or vim.g.os == 'Darwin'
vim.g.requirementVimDoge = vim.fn.executable('node')
vim.g.requirementGitPlugins = vim.g.nogitplugin == false
vim.g.requirementMarkdownPreviewNvim = vim.fn.executable('node') or vim.fn.executable('yarn')
vim.g.requirementVimCmake = vim.fn.executable('cmake')
vim.g.requirementVimGtest = vim.fn.executable('gtester')
EOF
