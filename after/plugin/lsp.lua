local Remap = require("kenjam.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

local cmp = require("cmp")
local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	path = "[Path]",
}
local lspkind = require("lspkind")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
	}),

	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]
			local menu = source_mapping[entry.source.name]
			vim_item.menu = menu
			return vim_item
		end,
	},

	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
	},
})

local function config(_config)
	local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

	return vim.tbl_deep_extend("force", {
		capabilities = capabilities,
		on_attach = function()
			nnoremap("gd", function()
				vim.lsp.buf.definition()
			end)
			nnoremap("K", function()
				vim.lsp.buf.hover()
			end)
			nnoremap("<leader>vws", function()
				vim.lsp.buf.workspace_symbol()
			end)
			nnoremap("<leader>vd", function()
				vim.diagnostic.open_float()
			end)
			nnoremap("[d", function()
				vim.diagnostic.goto_next()
			end)
			nnoremap("]d", function()
				vim.diagnostic.goto_prev()
			end)
			nnoremap("<leader>ca", function()
				vim.lsp.buf.code_action()
			end)
			nnoremap("<leader>rr", function()
				vim.lsp.buf.references()
			end)
			nnoremap("<leader>rn", function()
				vim.lsp.buf.rename()
			end)
			nnoremap("<leader>fm", function()
				require("conform").format()
			end)
			inoremap("<C-h>", function()
				vim.lsp.buf.signature_help()
			end)
		end,
	}, _config or {})
end

require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		"ts_ls",
		"clangd",
		"tailwindcss",
	},
	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup(config())
		end,

		["lua_ls"] = function()
			require("lspconfig").lua_ls.setup(config({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim", "it", "describe", "before_each", "after_each" },
						},
					},
				},
			}))
		end,
	},
})

vim.diagnostic.config({
	virtual_text = true,
})

require("lspconfig").ts_ls.setup(config())
require("lspconfig").clangd.setup(config())
require("lspconfig").tailwindcss.setup(config())
require("lspconfig").ruby_lsp.setup(config())
require("lspconfig").pyright.setup(config())
require("lspconfig").ols.setup({
	init_options = {
		checker_args = "-strict-style",
		collections = {
			{ name = "shared", path = vim.fn.expand("$HOME/odin-lib") },
		},
	},
	config(),
})

local opts = {
	highlight_hovered_item = true,
	show_guides = true,
}

require("symbols-outline").setup(opts)
