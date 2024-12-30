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

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Flash the yanked text',
  group = augroup('yank-highlight'),
  callback = function()
    vim.highlight.on_yank({ timeout = 50 })
  end,
})

--- List of filetypes to close with <q>
vim.g.quickclose = {
  help = 'bd',
  checkhealth = 'q',
  man = 'q',
  qf = 'q',
  query = 'q',
}

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Close some windows with <q>',
  group = augroup('quickclose'),
  pattern = '*',
  callback = function(event)
    local rhs = vim.tbl_get(vim.g.quickclose, event.match)
    if rhs then
      vim.bo[event.buf].buflisted = false
      vim.keymap.set('n', 'q', '<Cmd>' .. rhs .. '<CR>', {
        buffer = event.buf,
        silent = true,
        desc = 'Quit Window',
      })
    end
  end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Jump to last cursor position when entering a file',
  pattern = '*',
  group = augroup('jump-to-last-position'),
  callback = function(ev)
    if ev.match:match('COMMIT_EDITMSG') then
      return
    end

    -- ref: garybernhardt/dotfiles
    local line = vim.fn.line('\'"')
    if line > 0 and line <= vim.fn.line('$') then
      vim.cmd.normal('g`"')
    end
  end,
})

-- Ref: https://github.com/LazyVim/LazyVim/blob/12818a6c/lua/lazyvim/config/autocmds.lua#L111
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  desc = 'Create all the necessary directories when saving a file',
  group = augroup('auto-create-dir'),
  callback = function(event)
    if event.match:match('^%w%w+:[\\/][\\/]') then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})
