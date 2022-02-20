if vim.fn.executable('git') == false then
  vim.g.nogitplugin = true
else
  if vim.g.nogitplugin == nil then
    vim.g.nogitplugin = false
  end
end

vim.g.plug_reqr = {
  suda_vim = vim.fn.executable('sudo') == 1;
  fzf_install = vim.g.os == 'Windows' or vim.g.os == 'Darwin';
  fzf_vim = vim.g.os == 'Windows' and (vim.fn.executable('bash') == 1);
  fzf_lua = vim.g.os ~= 'Windows';
  vim_doge = vim.fn.executable('node') == 1;
  git_plugins = vim.g.nogitplugin == false;
  markdown_preview = vim.fn.executable('node') == 1 or vim.fn.executable('yarn') == 1;
  nvim_spectre = vim.fn.executable('sed') == 1;
}
