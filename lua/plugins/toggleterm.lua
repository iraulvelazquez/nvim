return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 20,
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			shade_terminals = true,
			start_in_insert = true,
			insert_mappings = true,
			terminal_mappings = true,
			persist_size = true,
			direction = "float",
			close_on_exit = false,
			shell = vim.o.shell,
			float_opts = {
				border = "curved",
				winblend = 0,
			},
		})

		local Terminal = require("toggleterm.terminal").Terminal

		local function compile()
			local filetype = vim.bo.filetype
			local filename = vim.fn.expand("%:t")
			local basename = vim.fn.expand("%:t:r")

			local compile_cmd = ""

			if filetype == "c" then
				compile_cmd = string.format("gcc -g -Wall -Wextra '%s' -o '%s'", filename, basename)
			elseif filetype == "cpp" then
				compile_cmd = string.format("g++ -g -Wall -Wextra '%s' -o '%s'", filename, basename)
			elseif filetype == "python" then
				compile_cmd = string.format("python -m py_compile '%s'", filename)
			elseif filetype == "tex" then
				-- Para LaTeX, muestra la salida completa
				compile_cmd = string.format("latexmk -pdf -interaction=nonstopmode -synctex=1 '%s'", filename)
			else
				vim.notify("Tipo de archivo no soportado para compilación", vim.log.levels.ERROR)
				return
			end

			local compile_term = Terminal:new({
				cmd = compile_cmd,
				direction = "float",
				close_on_exit = false, -- Mantener abierta para ver errores
				on_exit = function(_, _, exit_code)
					if exit_code == 0 then
						vim.notify("✓ Compilación exitosa", vim.log.levels.INFO)
						-- Si es LaTeX, abre Zathura automáticamente
						if filetype == "tex" then
							local pdf = basename .. ".pdf"
							if vim.fn.filereadable(pdf) == 1 then
								vim.fn.jobstart({ "zathura", pdf }, { detach = true })
							end
						end
					else
						vim.notify("✗ Error en compilación", vim.log.levels.ERROR)
					end
				end,
			})
			compile_term:toggle()
		end

		local function run()
			local filetype = vim.bo.filetype
			local filename = vim.fn.expand("%:t")
			local basename = vim.fn.expand("%:t:r")

			local run_cmd = ""

			if filetype == "c" or filetype == "cpp" then
				if vim.fn.filereadable(basename) == 0 then
					vim.notify("Primero compila el programa con <leader>c", vim.log.levels.WARN)
					return
				end
				run_cmd = string.format("./'%s'", basename)
			elseif filetype == "python" then
				run_cmd = string.format("python '%s'", filename)
			else
				vim.notify("Tipo de archivo no soportado para ejecución", vim.log.levels.ERROR)
				return
			end

			local run_term = Terminal:new({
				cmd = run_cmd,
				direction = "float",
				close_on_exit = false,
			})
			run_term:toggle()
		end

		-- Keymaps
		vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Exit to terminal normal mode" })
		vim.keymap.set("n", "<leader>c", compile, { desc = "Compile current file" })
		vim.keymap.set("n", "<leader>r", run, { desc = "Run current file" })
		vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
	end,
}
