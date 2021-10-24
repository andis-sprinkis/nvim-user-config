if vim.fn.executable('git') == false then
  vim.g.nogitplugin = true
else
  if vim.g.nogitplugin == nil then 
    vim.g.nogitplugin = false 
  end
end

vim.g.meetsPlugRequirement = {
  cocNvim = vim.fn.executable('node') == 1 and vim.fn.executable('yarn') == 1;
  sudaVim = vim.fn.executable('sudo') == 1;
  fzfInstall = vim.g.os == 'Windows' or vim.g.os == 'Darwin';
  fzfVim = vim.fn.executable('bash') == 1 or vim.fn.executable('zsh') == 1;
  vimDoge = vim.fn.executable('node') == 1;
  gitPlugins = vim.g.nogitplugin == false;
  markdownPreview = vim.fn.executable('node') == 1 or vim.fn.executable('yarn') == 1;
  vimCmake = vim.fn.executable('cmake') == 1;
  vimGtest = vim.fn.executable('gtester') == 1;
}
