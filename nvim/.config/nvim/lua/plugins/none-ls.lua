return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.completion.spell,
				null_ls.builtins.diagnostics.ltrs,
				null_ls.builtins.formatting.prettier.with({
					filetypes = {
						"json",
						"yaml",
						"markdown",
						"html",
						"vue",
						toml = { "--tab-width=2" },
						css = { "--tab-width=2" },
					},
				}),
			},
		})

		vim.keymap.set("n", "<leader>kf", vim.lsp.buf.format, {})
	end,
}
