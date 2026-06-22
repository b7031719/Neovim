return {
	{
		-- The core completion engine for Neovim, provides the UI and logic for the completion menu
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- Pulls completion suggestions from Neovim's built-in LSP client, the bridge between lsp and nvim-cmp
			"hrsh7th/cmp-buffer", -- local buffer completion sources
			"hrsh7th/cmp-path", -- path completions
			"L3MON4D3/LuaSnip", -- Provides code snippets (code templates)
			"saadparwaiz1/cmp_luasnip", -- Makes LuaSnip snippets available in the nvim-cmp completion list
			"rafamadriz/friendly-snippets", -- A snippet collection for vscode snippets
			"onsails/lspkind.nvim", -- icons and source labels
		},
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load() -- load friendly-snippets
			local lspkind = require("lspkind")

			return {
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},

				-- VIEW OPTIONS
				view = {
					entries = {
						name = "custom",
						selection_order = "near_cursor",
						follow_cursor = true,
					},
				},

				-- WINDOW OPTIONS
				window = {
					completion = cmp.config.window.bordered({
						border = "rounded",
						max_height = 15,
						side_padding = 1,
					}),
					documentation = cmp.config.window.bordered({
						border = "rounded",
						side_padding = 1,
					}),
				},

				-- KEYMAPS
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping(function(fallback)
						if cmp.visible() and cmp.get_selected_entry() then
							cmp.confirm({ select = false }) -- only confirm if something is selected
						else
							fallback() -- otherwise do normal <CR> (newline)
						end
					end),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),

				-- COMPLETION SOURCES
				sources = cmp.config.sources({
					{ name = "nvim_lsp" }, -- Completions from LSP
					{ name = "luasnip" }, -- Completions from LuaSnip
					{ name = "buffer", keyword_length = 3 },
					{ name = "path" },
					{ name = "render-markdown" }, -- from the render-markdown plugin
				}),

				-- FORMATTING OF POPUP
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "…",
						menu = {
							nvim_lsp = "[LSP]",
							luasnip = "[Snippet]",
							buffer = "[Buffer]",
							path = "[Path]",
							["render-markdown"] = "[Markdown]",
						},
						symbol_map = {
							Text = "󰉿",
							Method = "󰆧",
							Function = "󰊕",
							Constructor = "",
							Field = "󰜢",
							Variable = "󰀫",
							Class = "󰠱",
							Interface = "",
							Module = "",
							Property = "󰜢",
							Unit = "󰑭",
							Value = "󰎠",
							Enum = "",
							Keyword = "󰌋",
							Snippet = "",
							Color = "󰏫",
							File = "󰈙",
							Reference = "󰈇",
							Folder = "󰉋",
							EnumMember = "",
							Constant = "󰏿",
							Struct = "󰙅",
							Event = "",
							Operator = "󰆕",
							TypeParameter = "󰊕",
						},
					}),
				},
			}
		end,
	},
}
