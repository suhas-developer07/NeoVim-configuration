return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- for file icons
	},
	config = function()
		local nvimtree = require("nvim-tree")

		-- Disable netrw (recommended)
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		nvimtree.setup({
			sort = {
				sorter = "case_sensitive",
			},
			view = {
				width = 35,
				side = "left",
				relativenumber = true,
				signcolumn = "yes",
			},
			renderer = {
				root_folder_label = false,
				highlight_git = true,
				highlight_opened_files = "name",
				indent_markers = {
					enable = true,
					icons = {
						corner = "└ ",
						edge = "│ ",
						item = "│ ",
						bottom = "─",
						none = "  ",
					},
				},
				icons = {
					glyphs = {
						default = "",
						symlink = "",
						folder = {
							arrow_closed = "", -- arrow when closed
							arrow_open = "", -- arrow when open
							default = "",
							open = "",
							empty = "",
							empty_open = "",
							symlink = "",
						},
						git = {
							unstaged = "",
							staged = "S",
							unmerged = "",
							renamed = "➜",
							untracked = "U",
							deleted = "",
							ignored = "◌",
						},
					},
				},
			},
			filters = {
				dotfiles = false, -- show dotfiles
				custom = { ".git" }, -- but hide .git folder
			},
			git = {
				enable = true,
				ignore = false,
				show_on_dirs = true,
				timeout = 500,
			},
			actions = {
				open_file = {
					quit_on_open = false,
					window_picker = {
						enable = false,
					},
				},
			},
		})

		-- Keymap
		vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>", { noremap = true, silent = true })
	end,
}
