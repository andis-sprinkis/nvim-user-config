-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/user-00/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/user-00/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/user-00/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/user-00/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/user-00/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim"
  },
  ["any-jump.vim"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/any-jump.vim"
  },
  bufstop = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/bufstop"
  },
  ["coc.nvim"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/coc.nvim"
  },
  ["ctrlsf.vim"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/ctrlsf.vim"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/editorconfig-vim"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["git-messenger.vim"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/git-messenger.vim"
  },
  indentLine = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/indentLine"
  },
  ["lightline-gruvbox-dark.vim"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/lightline-gruvbox-dark.vim"
  },
  ["lightline-hunks"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/lightline-hunks"
  },
  ["lightline.vim"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/lightline.vim"
  },
  ["markdown-preview.nvim"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim"
  },
  neoterm = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/neoterm"
  },
  ["paq-nvim"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/paq-nvim"
  },
  ["splitjoin.vim"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/splitjoin.vim"
  },
  ["suda.vim"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/suda.vim"
  },
  ["traces.vim"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/traces.vim"
  },
  ["vim-MvVis"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/vim-MvVis"
  },
  ["vim-cmake"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/vim-cmake"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-dirvish"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/vim-dirvish"
  },
  ["vim-doge"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/vim-doge"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/vim-eunuch"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-gitgutter"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/vim-gitgutter"
  },
  ["vim-gruvbox8"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/vim-gruvbox8"
  },
  ["vim-gtest"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/vim-gtest"
  },
  ["vim-illuminate"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/vim-illuminate"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/vim-polyglot"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/vim-snippets"
  },
  ["vim-table-mode"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/vim-table-mode"
  },
  ["vim-wordmotion"] = {
    loaded = true,
    path = "/home/user-00/.local/share/nvim/site/pack/packer/start/vim-wordmotion"
  }
}

time([[Defining packer_plugins]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
