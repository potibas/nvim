local function augroup(name)
  return vim.api.nvim_create_augroup('potibas.' .. name, { clear = true })
end

vim.api.nvim_create_autocmd('FileType', {
  desc = "Don't insert comments on new lines",
  pattern = '*',
  group = augroup('no-comments-on-new-lines'),
  callback = function()
    vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
  end,
})
