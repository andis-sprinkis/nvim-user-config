if vim.fn.executable('git') == false then
  vim.g.nogitplugin = true
else
  if vim.g.nogitplugin == nil then 
    vim.g.nogitplugin = false 
  end
end

vim.g.meets_plug_requirement = {
  coc_nvim = vim.fn.executable('node') == 1 and vim.fn.executable('yarn') == 1;
  suda_vim = vim.fn.executable('sudo') == 1;
  fzf_install = vim.g.os == 'Windows' or vim.g.os == 'Darwin';
  fzf_vim = vim.fn.executable('bash') == 1 or vim.fn.executable('zsh') == 1;
  vim_doge = vim.fn.executable('node') == 1;
  git_plugins = vim.g.nogitplugin == false;
  markdown_preview = vim.fn.executable('node') == 1 or vim.fn.executable('yarn') == 1;
  vim_cmake = vim.fn.executable('cmake') == 1;
  vim_gtest = vim.fn.executable('gtester') == 1;
  nvim_spectre = vim.fn.executable('sed') == 1;
}