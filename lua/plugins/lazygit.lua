return {
  'kdheepak/lazygit.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },

  init = function()
    vim.g.lazygit_use_custom_config_file_path = 1

    vim.g.lazygit_config_file_path = vim.fs.joinpath(
      vim.fn.expand('$HOME'),
      '.config',
      'lazygit',
      'config.yml'
    )

    -- vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
    -- vim.g.lazygit_floating_window_scaling_factor = 0.85 -- scaling factor for floating window
    -- vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } -- customize lazygit popup window border characters
    -- vim.g.lazygit_floating_window_use_plenary = 1 -- use plenary.nvim to manage floating window if available
  end,

  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },

  keys = {
    { '<C-g><C-l>', vim.cmd.LazyGit, desc = 'LazyGit' },
    { '<C-g>l', vim.cmd.LazyGit, desc = 'LazyGit' },
    { '<C-g><C-i>', vim.cmd.LazyGitFilterCurrentFile, desc = 'LazyGit file Log' },
    { '<C-g>i', vim.cmd.LazyGitFilterCurrentFile, desc = 'LazyGit file Log' },
    { '<C-g><C-o>', vim.cmd.LazyGitFilter, desc = 'LazyGit Log' },
    { '<C-g>o', vim.cmd.LazyGitFilter, desc = 'LazyGit Log' },
  },
}
