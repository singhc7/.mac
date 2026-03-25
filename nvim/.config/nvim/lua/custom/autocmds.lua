-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- jump to last edit position on opening file
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function(ev)
    if vim.fn.line "'\"" > 1 and vim.fn.line "'\"" <= vim.fn.line "$" then
      -- except for in git commit messages
      -- https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
      if not vim.fn.expand('%:p'):find('.git', 1, true) then
        vim.cmd 'exe "normal! g\'\\""'
      end
    end
  end,
})

-- shorter columns in text because it reads better that way
local text = vim.api.nvim_create_augroup('text', { clear = true })
for _, pat in ipairs { 'text', 'markdown', 'mail', 'gitcommit' } do
  vim.api.nvim_create_autocmd('Filetype', {
    pattern = pat,
    group = text,
    command = 'setlocal spell tw=72 colorcolumn=73',
  })
end
--- tex has so much syntax that a little wider is ok
vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'tex',
  group = text,
  command = 'setlocal spell tw=80 colorcolumn=81',
})

-- Map Caps Lock to Escape only when Neovim is in focus
-- This uses GNOME gsettings, as detected in your environment.
local function set_caps_to_esc()
  vim.fn.jobstart 'gsettings set org.gnome.desktop.input-sources xkb-options "[\'caps:escape\']"'
end

local function reset_caps()
  vim.fn.jobstart 'gsettings reset org.gnome.desktop.input-sources xkb-options'
end

local caps_group = vim.api.nvim_create_augroup('caps-to-esc', { clear = true })

vim.api.nvim_create_autocmd({ 'VimEnter', 'FocusGained' }, {
  group = caps_group,
  callback = set_caps_to_esc,
})

vim.api.nvim_create_autocmd({ 'VimLeave', 'FocusLost' }, {
  group = caps_group,
  callback = reset_caps,
})
