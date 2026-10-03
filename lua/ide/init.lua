-- lua/ide/init.lua
-- Loads every file in lua/ide/plugins/. Each returns:
--   { spec = <url | {src=,version=} | list of those>, config = fn?, order = n? }

local dir = vim.fn.stdpath("config") .. "/lua/ide/plugins"
local mods = {}

local function err(msg)
  vim.notify("ide: " .. msg, vim.log.levels.ERROR)
end

-- 1. collect plugin modules (runs each file's top-level code, e.g. PackChanged autocmds)
for name, kind in vim.fs.dir(dir) do
  if (kind == "file" or kind == "link") and name:match("%.lua$") then
    local mod = name:gsub("%.lua$", "")
    local ok, m = pcall(require, "ide.plugins." .. mod)
    if not ok then
      err("failed to load " .. mod .. "\n" .. tostring(m))
    elseif type(m) ~= "table" then
      err(mod .. " must return a table")
    else
      m.name = m.name or mod
      table.insert(mods, m)
    end
  end
end

-- 2. stable load order: lower `order` first, ties by name
table.sort(mods, function(a, b)
  local oa, ob = a.order or 50, b.order or 50
  if oa ~= ob then return oa < ob end
  return a.name < b.name
end)

-- 3. flatten specs, naming any bad one
local specs = {}
local function add(spec, from)
  if spec == nil then
    return
  elseif type(spec) == "string" or (type(spec) == "table" and spec.src) then
    table.insert(specs, spec)
  elseif type(spec) == "table" and spec[1] ~= nil then
    for _, s in ipairs(spec) do add(s, from) end
  else
    err("bad spec in " .. from .. ": " .. vim.inspect(spec) .. " (table specs need src = ...)")
  end
end
for _, m in ipairs(mods) do add(m.spec, m.name) end

-- 4. install + load
local ok, e = pcall(vim.pack.add, specs)
if not ok then
  err("vim.pack.add failed\n" .. tostring(e))
  return
end

-- 5. configure in order; one broken plugin doesn't stop the rest
for _, m in ipairs(mods) do
  if m.config then
    local cok, cerr = pcall(m.config)
    if not cok then err(m.name .. " config failed\n" .. tostring(cerr)) end
  end
end
