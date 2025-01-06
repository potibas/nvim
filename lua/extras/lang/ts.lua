return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = { ensure_installed = { 'vtsls', 'eslint-lsp' } },
  },

  {
    'neovim/nvim-lspconfig',
    opts = { servers = { 'vtsls', 'eslint' } },
  },
}
