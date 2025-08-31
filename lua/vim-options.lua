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
vim.api.nvim_set_keymap("i", "jk", "<ESC>", { noremap = true })
vim.opt.clipboard = "unnamedplus"

-- This keymap clears the search
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err")
vim.keymap.set("n", "<leader>ff", ":!gofmt -w %<CR><CR>")
vim.keymap.set("n", "<leader>pp", ":!prettier -w %<CR><CR>") -- prettier formatter

-- Split management
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>s", ":split<CR>", { desc = "Horizontal split" })
vim.keymap.set("n", "<leader>q", ":close<CR>", { desc = "Close split" })

-- Tab management
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Close tab" })
vim.keymap.set("n", "<Tab>", "gt", { desc = "Next tab" })
vim.keymap.set("n", "<S-Tab>", "gT", { desc = "Previous tab" })

-- Buffer management
vim.keymap.set("n", "<leader>bn", ":bn<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bp<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Close buffer" })
-- VS Code style Ctrl+Tab for previous file
-- Guaranteed to work: leader + Tab
vim.keymap.set("n", "<leader><Tab>", ":b#<CR>", { desc = "Switch to previous buffer" })
vim.keymap.set("i", "<leader><Tab>", "<Esc>:b#<CR>a", { desc = "Switch to previous buffer" })

-- Undo/Redo in Insert Mode
vim.keymap.set("i", "<C-z>", "<C-o>u", { desc = "Undo in insert mode" })
vim.keymap.set("i", "<C-y>", "<C-o><C-r>", { desc = "Redo in insert mode" })

-- Enhanced word highlighting
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Double-click highlighting with visual feedback
-- Improved double-click highlighting
vim.keymap.set("n", "<2-LeftMouse>", function()
	local word = vim.fn.expand("<cword>")
	if word ~= "" then
		-- Use very magic regex to handle special characters
		vim.cmd('let @/ = "\\V\\<' .. word .. '\\>"')
		vim.cmd("set hlsearch")
		vim.api.nvim_echo({ { "Highlighting: ", "Comment" }, { word, "Identifier" } }, true, {})
	end
end, { desc = "Highlight word on double-click" })

-- Fix space delay in insert mode
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 10

-- Disable which-key for space in insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		vim.opt.timeoutlen = 50
	end,
})
