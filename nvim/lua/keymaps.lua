-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
vim.keymap.set('n', '<C-S-h>', '<C-w>H', { desc = 'Move window to the left' })
vim.keymap.set('n', '<C-S-l>', '<C-w>L', { desc = 'Move window to the right' })
vim.keymap.set('n', '<C-S-j>', '<C-w>J', { desc = 'Move window to the lower' })
vim.keymap.set('n', '<C-S-k>', '<C-w>K', { desc = 'Move window to the upper' })

-- NeoTree related keybindings
vim.keymap.set('n', '<leader>e', function()
  -- Get the full path of the current buffer's file
  local current_file = vim.fn.expand '%:p'
  -- Get the buffer type (e.g., '', 'nofile', 'terminal', 'help')
  local buftype = vim.bo.buftype

  -- Prepare arguments for the Neo-tree command
  local args = {
    action = 'toggle', -- Toggle the tree open/closed
    source = 'filesystem', -- Ensure it's the file system source
    position = 'left', -- Or "right" depending on your preference
  }

  -- Check if the current buffer is a regular file buffer and has a path
  if current_file ~= '' and buftype == '' then
    -- If it's a file, add the reveal_file argument
    args.reveal_file = current_file
    -- Optional: force changing the working directory if the file is outside the current root
    args.reveal_force_cwd = true
  end

  -- Execute the Neo-tree command with the prepared arguments
  -- Lazy.nvim ensures the plugin is loaded before this function is called by the keymap.
  require('neo-tree.command').execute(args)
end)

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
