vim.g.mapleader = " "

vim.o.relativenumber = true
vim.o.number = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.showmode = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- This keybinding uses jk as escape but don't know if like it 
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', { noremap = true })
vim.opt.clipboard = 'unnamedplus'

-- This keymap clears the search
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err")
vim.keymap.set("n", "<leader>ff", ":!gofmt -w %<CR><CR>")
vim.keymap.set("n", "<leader>pp", ":!prettier -w %<CR><CR>") -- prettier formatter


-- Split management
vim.keymap.set('n', '<leader>v', ':vsplit<CR>', { desc = 'Vertical split' })
vim.keymap.set('n', '<leader>s', ':split<CR>', { desc = 'Horizontal split' })
vim.keymap.set('n', '<leader>q', ':close<CR>', { desc = 'Close split' })

-- Tab management
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close tab' })
vim.keymap.set('n', '<Tab>', 'gt', { desc = 'Next tab' })
vim.keymap.set('n', '<S-Tab>', 'gT', { desc = 'Previous tab' })

-- Buffer management
vim.keymap.set('n', '<leader>bn', ':bn<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bp', ':bp<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { desc = 'Close buffer' })
