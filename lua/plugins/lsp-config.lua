return {
	{
		"mason-org/mason.nvim",
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"stylua",
					"ruff",
					"clang-format",
					"latexindent",
					"cpplint",
					-- cppcheck en el sistema
				},
				auto_update = false,
				run_on_start = true,
			})
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
					"cmake",
					"rust_analyzer",
					"pylsp",
					"texlab",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason-lspconfig.nvim",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
			vim.lsp.config("texlab", {
				capabilities = capabilities,
				settings = {
					texlab = {
						build = {
							executable = "latexmk",
							args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
							onSave = true,
						},
						forwardSearch = {
							executable = "zathura",
							args = { "--synctex-forward", "%l:1:%f", "%p" },
						},
					},
				},
			})

			vim.lsp.config("clangd", { capabilities = capabilities })
			vim.lsp.config("cmake", { capabilities = capabilities })
			vim.lsp.config("rust_analyzer", { capabilities = capabilities })
			vim.lsp.config("pylsp", { capabilities = capabilities })
			vim.lsp.config("texlab", { capabilities = capabilities })
			vim.lsp.enable("clangd")
			vim.lsp.enable("cmake")
			vim.lsp.enable("rust_analyzer")
			vim.lsp.enable("pylsp")
			vim.lsp.enable("texlab")
			vim.lsp.enable("lua_ls")
			-- Zathura
			vim.keymap.set("n", "<leader>z", function()
				local pdf = vim.fn.expand("%:r") .. ".pdf"
				if vim.fn.filereadable(pdf) == 1 then
					vim.fn.jobstart({ "zathura", pdf }, { detach = true })
					vim.notify("📖 Abriendo " .. pdf, vim.log.levels.INFO)
				else
					vim.notify("❌ PDF no encontrado: " .. pdf, vim.log.levels.ERROR)
				end
			end, { desc = "Open PDF with Zathura" })

			vim.keymap.set("n", "<leader>v", function()
				local clients = vim.lsp.get_clients({ bufnr = 0, name = "texlab" })
				if #clients == 0 then
					vim.notify("⚠ texlab no está activo", vim.log.levels.WARN)
					return
				end

				local params = {
					textDocument = vim.lsp.util.make_text_document_params(),
					position = vim.lsp.util.make_position_params().position,
				}

				clients[1].request("textDocument/forwardSearch", params, function(err, _)
					if err then
						vim.notify("❌ Error en forward search: " .. vim.inspect(err), vim.log.levels.ERROR)
					end
				end, 0)
			end, { desc = "Forward search to PDF" })

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
