-- lua/plugins/theme.lua
return {
	-- Catppuccin
	-- Catppuccin
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				integrations = {
					lualine = true, -- 👈 enables Catppuccin theme for lualine
					treesitter = true,
					nvimtree = true,
					telescope = true,
					cmp = true,
					gitsigns = true,
				},
			})
		end,
	},

	-- Tokyo Night
	{
		"folke/tokyonight.nvim",
		lazy = true,
		config = function()
			require("tokyonight").setup({
				style = "storm", -- storm, night, moon, day
			})
		end,
	},

	-- Gruvbox Material
	{
		"sainnhe/gruvbox-material",
		lazy = true,
	},

	-- Everforest
	{
		"sainnhe/everforest",
		lazy = true,
	},

	-- THEME SWITCHER
	{
		"nvim-lua/plenary.nvim", -- dependency
		lazy = false,
		config = function()
			local themes = {
				"catppuccin",
				"tokyonight",
				"gruvbox-material",
				"everforest",
			}
			local current = 1

			vim.keymap.set("n", "<leader>tt", function()
				current = current % #themes + 1
				vim.cmd("colorscheme " .. themes[current])
				print("Switched to theme: " .. themes[current])
			end, { desc = "Toggle Theme" })
		end,
	},
}
