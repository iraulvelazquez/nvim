return {
	"NStefan002/screenkey.nvim",
	lazy = false,
	version = "*",
	config = function()
		vim.keymap.set("n", "<leader>sc", ":Screenkey<CR>", {})
	end,
}
