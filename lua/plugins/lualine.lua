return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "codedark",
        globalstatus = true
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return str
						end,
					},
				},
			},
		})
	end,
}
