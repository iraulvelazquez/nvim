return {
	{
		"daschw/leaf.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("leaf").setup({
				underline_errors = true,
				comment_style = { italic = true },
				functionStyle = "NONE",
				keywordStyle = "italic",
				statementStyle = "bold",
				typeStyle = "NONE",
				variablebuiltinStyle = "italic",
				transparent = false,
				colors = {},
				overrides = {},
				theme = "auto",
				contrast = "low",
			})

			vim.cmd.colorscheme("leaf")
		end,
	},
}
