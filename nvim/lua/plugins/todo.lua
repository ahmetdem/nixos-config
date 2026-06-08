return {
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local todo = require("todo-comments")

			todo.setup({
				-- Highlights to match your Cyberdream theme
				colors = {
					error = { "DiagnosticError", "ErrorMsg", "#ff5e5e" },
					warning = { "DiagnosticWarn", "WarningMsg", "#ffbd5e" },
					info = { "DiagnosticInfo", "#5fffe0" }, -- Cyberdream Cyan
					hint = { "DiagnosticHint", "#bd5eff" },
					default = { "Identifier", "#707a7c" },
				},
			})

			local map = vim.keymap.set
			-- Open all project todos in Telescope
			map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find TODOs" })
			-- Open todos in Trouble (since you already have it installed)
			map("n", "<leader>qt", "<cmd>TodoTrouble<cr>", { desc = "TODOs (Trouble)" })

			-- Quick navigation between comments
			map("n", "]t", function() todo.jump_next() end, { desc = "Next todo comment" })
			map("n", "[t", function() todo.jump_prev() end, { desc = "Previous todo comment" })
		end,
	},
}
