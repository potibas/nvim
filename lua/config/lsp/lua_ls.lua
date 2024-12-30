---@see https://luals.github.io/wiki/settings
return {
  settings = {

    Lua = {
      format = { enable = false },

      diagnostics = {
        globals = { 'vim', 'spec' },
        disable = { 'missing-fields' },
      },

      runtime = {
        version = 'LuaJIT',
        special = { spec = 'require' },
      },

      -- workspace = {
      --   library = {
      --     [vim.fn.expand("$VIMRUNTIME/lua")] = true,
      --     [vim.fn.stdpath("data") .. "/lua"] = true,
      --   },
      -- },

      codeLens = { enable = false },

      completion = { callSnippet = 'Replace' },

      doc = { privateName = { '^_' } },

      hint = {
        enable = true,
        paramType = true,
        paramName = true,
        setType = false,
        arrayIndex = 'Disable',
        semicolon = 'Disable',
      },
    },
  },

  -- Force single-file mode
  -- root_dir = function()
  --   return false
  -- end

  root_dir = function(fname)
    local util = require('lspconfig.util')
    local root_pattern = util.root_pattern('.git', '*.rockspec')(fname)

    if fname ~= vim.uv.os_homedir() then
      return nil
    end

    return root_pattern or fname
  end,
}
