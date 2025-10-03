return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				file_ignore_patterns = {
					"node_modules",
					"node_modules/*",
					"/node_modules/*",
					".git",
					".cache",
					".venv",
					".vscode",
					".DS_Store",
					".idea",
					".vscode",
					".gitignore",
					".gitmodules",
					".gitattributes",
					".gitlab-ci.yml",
					".gitlab",
					".gitlab-ci",
					"Debug/*",
					"/Debug/*",
					"Debug",
					"obj/*",
					"/obj/*",
					"obj",
					"build",
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader><leader>", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fu", builtin.lsp_references, {})

			require("telescope").load_extension("ui-select")
		end,
	},
}
