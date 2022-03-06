local function has_module(modules)
  if modules == nil then return true end

  local function is_module_available(name)
    if package.loaded[name] then
      return true
    else
      for _, searcher in ipairs(package.searchers or package.loaders) do
        local loader = searcher(name)
        if type(loader) == 'function' then
          package.preload[name] = loader
          return true
        end
      end
      return false
    end
  end

  for _, value in ipairs(modules) do if not is_module_available[value] then return false end end

  return true
end


local function has_sys_reqr(requirements)
  if requirements == nil then return true end

  for _, value in ipairs(requirements) do if not vim.g.sys_reqr[value] then return false end end

  return true
end

local function has_plugs (plugs)
  if plugs == nil then return true end

  for _, value in ipairs(plugs) do if not vim.g.plugs[value] then return false end end

  return true
end

local function require_all (modules)
  if (modules ~= nil) then for _, value in ipairs(modules) do require(value) end end
end

local function call_cb(cb)
  if cb ~= nil then cb() end
end

local function with_reqr (args)
  if (args.dependency.sys_reqr ~= nil and not has_sys_reqr(args.dependency.sys_reqr))
    or (args.dependency.plugs ~= nil and not has_plugs(args.dependency.plugs))
  then
    call_cb(args.dependant.unmet_cb)
    return
  end

  require_all(args.dependant.modules)
  call_cb(args.dependant.cb)
end

return {
  has_module = has_module,
  has_sys_reqr = has_sys_reqr,
  has_plugs = has_plugs,
  with_reqr = with_reqr
}
