-- All language servers are configured in this file
return {
	{
		-- Neovim built in LSP client
		-- Sends and receives events from Neovim to language servers via language server protocol
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
			local servers = {
				"lua_ls",
				"pyright",
				"nixd",
				"ts_ls",
				"bashls",
				"html",
				"cssls",
			}

      -- Global LSP config
			vim.lsp.config("*", { capabilities = capabilities })

      -- lua_ls config
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = { vim.env.VIMRUNTIME },
							checkThirdParty = false,
							preloadFileSize = 10000,
						},
						telemetry = { enable = false },
						hint = { enable = true }, -- inlay hints
					},
				},
			})

      -- nixd config
			vim.lsp.config("nixd", {
				cmd = { "nixd" },
				settings = {
					nixd = {
						nixpkgs = {
							expr = "import <nixpkgs> { }",
						},
						formatting = {
							command = { "nixfmt" },
						},
					},
				},
			})

			-- Enable servers
			vim.lsp.enable(servers)

			-- Diagnostic settings
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			-- keymaps for language server functions
			vim.keymap.set("n", "gl", vim.diagnostic.open_float, {})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>oi", function()
				vim.lsp.buf.code_action({
					context = {
						only = { "source.organizeImports" },
						diagnostics = {}, -- helps some servers
					},
					apply = true,
				})
			end, { desc = "Organize Imports", buffer = true })
		end,
	},
}
