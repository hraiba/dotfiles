return {
	{
		"rose-pine/neovim",
		lazy = false,
		name = "rose-pine",
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				background = "dark",
				extend_bckground_behind_border = true,
				styles = {
					comments = "italic",
					functions = "italic",
					keywords = "italic",
					strings = "italic",
					variables = "italic",
					operators = "italic",
					numbers = "italic",
					booleans = "italic",
					conditionals = "italic",
					loops = "italic",
					properties = "italic",
					miscs = "italic",
				},
				highlight_groups = {
					TelescopeBorder = { fg = "highlight_high", bg = "none" },
					TelescopeNormal = { bg = "none" },
					TelescopePromptNormal = { bg = "base" },
					TelescopeResultsNormal = { fg = "subtle", bg = "none" },
					TelescopeSelection = { fg = "text", bg = "base" },
					TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
				},
			})
			-- vim.cmd([[colorscheme rose-pine]])
		end,
	},
}
