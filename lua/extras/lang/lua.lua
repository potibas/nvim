vim.api.nvim_create_autocmd('FileType', {
  desc = 'Register Lua specific keymaps',
  group = vim.api.nvim_create_augroup('potibas.keymaps.lua', { clear = true }),
  pattern = 'lua',
  callback = function(event)
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(
        mode,
        lhs,
        rhs,
        { desc = desc, buffer = event.buf, silent = true }
      )
    end

    map('n', ';;', '<Cmd>w|!stylua %<CR>', 'Format file with stylua')
  end,
})

return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = { ensure_installed = { 'lua_ls' } },
  },

  {
    'neovim/nvim-lspconfig',
    opts = { servers = { 'lua_ls' } },
  },

  {
    'folke/lazydev.nvim',
    ft = 'lua',
    cmd = 'LazyDev',

    dependencies = {
      { 'Bilal2453/luvit-meta', lazy = true }, -- optional `vim.uv` typings
    },

    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
}
