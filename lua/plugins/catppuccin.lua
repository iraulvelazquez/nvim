return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			transparent_background = true,
			integrations = {
				bufferline = false,
				neotree = false,
        toggleterm = false,
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
