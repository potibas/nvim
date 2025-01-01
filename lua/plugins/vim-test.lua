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
    { ';tn', '<Cmd>TestNearest<CR>', desc = 'Run nearest test' },
    { ';tf', '<Cmd>TestFile<CR>', desc = 'Test file' },
    { ';ta', '<Cmd>TestSuite<CR>', desc = 'Test all' },
    { ';tt', '<Cmd>TestLast<CR>', desc = 'Repeat last test run' },
    { ';tN', '<Cmd>TestNearest -strategy=vimux<CR>', desc = 'Run nearest test with Vimux' },
    { ';tF', '<Cmd>TestFile -strategy=vimux<CR>', desc = 'Test file with Vimux' },
    { '<C-;>', '<Cmd>TestLast<CR>', desc = 'Repeat last test run' },
    { '<C-\'>', '<Cmd>TestLast -strategy=vimux<CR>', desc = 'Repeat last test run with Vimux' },
    -- stylua: ignore end
  },
}
