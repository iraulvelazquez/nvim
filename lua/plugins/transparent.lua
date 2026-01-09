return {
	"xiyaowong/transparent.nvim",
	lazy = false,
	config = function()
		require("transparent").clear_prefix("ToggleTerm")
		require("transparent").clear_prefix("NeoTree")
		require("transparent").clear_prefix("BufferLine")
		require("transparent").clear_prefix("Telescope")
		require("transparent").clear_prefix("Buffer")
		require("transparent").setup({
			groups = {
				"Normal",
				"NormalNC",
				"Comment",
				"Constant",
				"Special",
				"Identifier",
				"Statement",
				"PreProc",
				"Type",
				"Underlined",
				"Todo",
				"String",
				"Function",
				"Conditional",
				"Repeat",
				"Operator",
				"Structure",
				"LineNr",
				"NonText",
				"SignColumn",
				"CursorLine",
				"CursorLineNr",
				"StatusLine",
				"StatusLineNC",
				"EndOfBuffer",
			},
			extra_groups = {
				"NormalFloat",
				"FloatBorder",
				"FloatTitle",
				"Pmenu",
				"PmenuSel",
				"PmenuSbar",
				"PmenuThumb",
				"TelescopeNormal",
				"TelescopeBorder",
				"TelescopePromptNormal",
				"TelescopePromptBorder",
				"TelescopeResultNormal",
				"TelescopePreviewNormal",
				"NvimTreeNormal",
				"BufferLineFill",
				"BufferLineBackground",
				"BufferLineSeparator",
				"BufferLineIndicatorSelected",
				"ToggleTermNormalFloat",
				"ToggleTermFloatBorder",
        "LfNormalFloat",
			},
			on_clear = function() end,
		})
		vim.keymap.set("n", "<leader>tr", ":TransparentToggle<CR>", {})
	end,
}
