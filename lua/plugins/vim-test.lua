local f = require('lib.functions')

return {
  'vim-test/vim-test',
  dependencies = { 'preservim/vimux' },

  config = function()
    vim.g['#test#strategy'] = 'basic'
    vim.g['test#preserve_screen'] = true
    vim.g['test#no_alternate'] = true
    vim.g['VimuxHeight'] = 80
    vim.g['VimuxOrientation'] = 'h'
  end,

  keys = {
    -- stylua: ignore start
    { ';tv', '<Cmd>TestVisit<CR>', desc = 'Visit last test' },
    { ';tn', f.runner_with_save(vim.cmd.TestNearest), desc = 'Run nearest test' },
    { ';tf', f.runner_with_save(vim.cmd.TestFile), desc = 'Test file' },
    { ';ta', f.runner_with_save(vim.cmd.TestSuite), desc = 'Test all' },
    { ';tt', f.runner_with_save(vim.cmd.TestLast), desc = 'Repeat last test run' },
    { ';tN', f.runner_with_save(vim.cmd.TestNearest, '-strategy=vimux'), desc = 'Run nearest test with Vimux' },
    { ';tF', f.runner_with_save(vim.cmd.TestFile, '-strategy=vimux'), desc = 'Test file with Vimux' },
    { '<C-;>', f.runner_with_save(vim.cmd.TestLast), desc = 'Repeat last test run' },
    { "<C-'>", f.runner_with_save(vim.cmd.TestLast, '-strategy=vimux'), desc = 'Repeat last test run with Vimux' },
    -- stylua: ignore end
  },
}
