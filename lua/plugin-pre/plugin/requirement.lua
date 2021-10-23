if vim.fn.executable('git') == false then
  vim.g.nogitplugin = true
else
  if vim.g.nogitplugin == nil then 
    vim.g.nogitplugin = false 
  end
end

vim.g.requirementCocNvim = vim.fn.executable('node') == 1 and vim.fn.executable('yarn') == 1
vim.g.requirementSudaVim = vim.fn.executable('sudo') == 1
vim.g.requirementFzfInstall = vim.g.os == 'Windows' or vim.g.os == 'Darwin'
vim.g.requirementVimDoge = vim.fn.executable('node') == 1
vim.g.requirementGitPlugins = vim.g.nogitplugin == false
vim.g.requirementMarkdownPreviewNvim = vim.fn.executable('node') == 1 or vim.fn.executable('yarn') == 1
vim.g.requirementVimCmake = vim.fn.executable('cmake') == 1
vim.g.requirementVimGtest = vim.fn.executable('gtester') == 1
