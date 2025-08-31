return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },  -- ✅ FIXED: antosha417 (not 418)
		{ "folke/neodev.nvim", opts = {} },
		{
			"williamboman/mason.nvim",
			build = ":MasonUpdate", -- keep registry updated
		},
		{
			"williamboman/mason-lspconfig.nvim",
			version = "*", -- always pull latest
		},
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap

		-- capabilities for autocompletion
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- diagnostic signs
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end
        
		-- Enable diagnostics
		vim.diagnostic.config({
			virtual_text = true,  -- Show error messages inline
			signs = true,         -- Show signs in gutter
			underline = true,     -- Underline errors
			update_in_insert = false,
			severity_sort = true,
			float = {
				border = "rounded",
				source = "always",
			},
		})

		-- LSP keymaps when attached
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
				keymap.set("n", "K", vim.lsp.buf.hover, opts)
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

				-- ADD THESE TWO LINES:
				opts.desc = "Show function signature help"
				keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, opts)
				keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, opts)
			end,
		})

		-- Ensure some servers are installed
		mason_lspconfig.setup({
			ensure_installed = { "gopls", "html", "lua_ls", "emmet_ls", "graphql", "templ" },
		})

		-- Use setup_handlers if available (new versions), otherwise fallback
		if mason_lspconfig.setup_handlers then
			mason_lspconfig.setup_handlers({
				-- Default handler
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,

				-- Custom configs
				["graphql"] = function()
					lspconfig["graphql"].setup({
						capabilities = capabilities,
						filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
					})
				end,
				["emmet_ls"] = function()
					lspconfig["emmet_ls"].setup({
						capabilities = capabilities,
						filetypes = {
							"html",
							"templ",
							"typescriptreact",
							"javascriptreact",
							"css",
							"sass",
							"scss",
							"less",
							"svelte",
						},
					})
				end,
				["html"] = function()
					lspconfig["html"].setup({
						capabilities = capabilities,
						filetypes = { "html", "templ" },
					})
				end,
				["lua_ls"] = function()
					lspconfig["lua_ls"].setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = { globals = { "vim" } },
								completion = { callSnippet = "Replace" },
							},
						},
					})
				end,
			})
		else
			-- Fallback: older mason-lspconfig without setup_handlers
			for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
				local opts = { capabilities = capabilities }

				if server_name == "graphql" then
					opts.filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" }
				elseif server_name == "emmet_ls" then
					opts.filetypes = {
						"html",
						"templ",
						"typescriptreact",
						"javascriptreact",
						"css",
						"sass",
						"scss",
						"less",
						"svelte",
					}
				elseif server_name == "html" then
					opts.filetypes = { "html", "templ" }
				elseif server_name == "lua_ls" then
					opts.settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							completion = { callSnippet = "Replace" },
						},
					}
				end

				lspconfig[server_name].setup(opts)
			end
		end
	end,
}
