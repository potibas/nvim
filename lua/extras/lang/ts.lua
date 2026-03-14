return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = { ensure_installed = { 'vtsls', 'tailwindcss', 'eslint-lsp' } },
  },

  {
    'neovim/nvim-lspconfig',
    opts = { servers = { 'vtsls', 'eslint', 'tailwindcss' } },
  },
}
