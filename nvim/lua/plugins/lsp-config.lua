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

			-- Define a table of servers to configure
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
						format = { enable = false },
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
						options = {
							nixos = { expr = "(import <nixpkgs/nixos> {}).options" },
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

			-- keymaps function is buffer local
			local function lsp_keymaps(bufnr)
				local opts = { buffer = bufnr, silent = true }

				vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>td", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "<leader>ds", vim.lsp.buf.document_symbol, opts)
				vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)

				-- Organize imports (only for servers that support it)
				vim.keymap.set("n", "<leader>oi", function()
					vim.lsp.buf.code_action({
						context = {
							only = { "source.organizeImports" },
							diagnostics = {},
						},
						apply = true,
					})
				end, vim.tbl_extend("force", opts, { desc = "Organize Imports" }))
			end

			-- Attach keymaps to LSP attach event
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					lsp_keymaps(ev.buf)
				end,
			})
		end,
	},
}
