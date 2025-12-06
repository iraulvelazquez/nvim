return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("ibl").setup({
			indent = {
				char = "│",
			},
			scope = {
				enabled = true,
				show_start = true,
				show_end = true,
			},
		})
	end,
}
