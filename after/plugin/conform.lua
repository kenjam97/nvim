require("conform").setup({
	formatters = {
		odinfmt = {
			command = "odinfmt",
			args = { "-stdin" },
			stdin = true,
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		rust = { "rustfmt", lsp_format = "fallback" },
		html = { "prettierd" },
		javascript = { "prettierd" },
		javascriptreact = { "prettierd" },
		markdown = { "prettierd" },
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		go = { "gofmt" },
		odin = { "odinfmt" },
		["*"] = { "trim_whitespace" },
	},
})
