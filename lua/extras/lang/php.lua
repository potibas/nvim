vim.api.nvim_create_autocmd('FileType', {
  desc = 'Register PHP specific keymaps',
  group = vim.api.nvim_create_augroup('potibas.keymaps.php', { clear = true }),
  pattern = 'php',
  callback = function(event)
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(
        mode,
        lhs,
        rhs,
        { desc = desc, buffer = event.buf, silent = true }
      )
    end

    map('n', ';;', '<Cmd>w|!pint -q %<CR>', 'Format file with pint')
    map('i', '<C-.>', '->', 'Insert -> operator')

    map('n', '<Space>;', function()
      local f = require('lib.functions')
      local ok, _ = pcall(vim.cmd.s, '/[^;]$/\\0;')
      if not ok then
        f.info('Line already terminated with ;')
      else
        vim.cmd.normal('``')
      end
      vim.cmd.nohlsearch()
    end, 'Add `;` to end of the line')
    map('i', '<C-;>', '<C-o>A;<CR>', 'Close line with `;`')

    vim.opt_local.commentstring = '// %s'
  end,
})

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
