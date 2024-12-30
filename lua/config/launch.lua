---Configuration Launcher
LAUNCH_SPEC = {}

---Adds a module name to be imported in the final Lazy.nvim's spec
---@param modname string  The name of the module to import
function Spec(modname)
  table.insert(LAUNCH_SPEC, { import = modname })
end
