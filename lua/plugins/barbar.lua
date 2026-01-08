return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},
  event = 'VimEnter',
	init = function()
		vim.g.barbar_auto_setup = false
	end,
  opts = {
    exclude_ft = {'alpha'},
    auto_hide = true,
  },
	config = function()
		if vim.bo.filetype ~= "alpha" then
			require("barbar").setup({
				exclude_ft = { "alpha" },
				auto_hide = true,
			})
		end
		vim.keymap.set("n", "<Tab>", ":BufferNext<CR>", { silent = true })
		vim.keymap.set("n", "<S-Tab>", ":BufferPrevious<CR>", { silent = true })
		vim.keymap.set("n", "<C-c>", ":BufferClose<CR>", { silent = true })
	end,
	version = "^1.0.0",
}
