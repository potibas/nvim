return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = { ensure_installed = { 'intelephense', 'pint', 'phpstan' } },
  },

  {
    'neovim/nvim-lspconfig',
    opts = { servers = { 'intelephense' } },
  },

  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'php', 'php_only', 'phpdoc' },
    },
  },
}
