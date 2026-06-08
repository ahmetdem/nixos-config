return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				skip_confirm_for_simple_edits = true,
				delete_to_trash = true,

				columns = {
					"icon",
				},

				keymaps = {
					["g?"] = { "actions.show_help", mode = "n" },
					["<CR>"] = {
						callback = function()
							local oil = require("oil")
							local entry = oil.get_cursor_entry()
							if not entry then
								return
							end

							-- In a split with other windows: open file in main window, focus on file
							if entry.type == "file" and #vim.api.nvim_tabpage_list_wins(0) > 1 then
								local dir = oil.get_current_dir()
								local filepath = dir .. entry.name
								vim.cmd("wincmd p")
								vim.cmd("edit " .. vim.fn.fnameescape(filepath))
								vim.cmd("wincmd p")
							else
								-- Single window: default behavior
								oil.select()
							end
						end,
						mode = "n",
					},
					["<C-s>"] = { "actions.select", opts = { vertical = true } },
					["<C-h>"] = { "actions.select", opts = { horizontal = true } },
					["<C-t>"] = { "actions.select", opts = { tab = true } },
					["<C-p>"] = "actions.preview",
					["<C-c>"] = { "actions.close", mode = "n" },
					["<C-l>"] = "actions.refresh",
					[","] = { "actions.parent", mode = "n" },
					["_"] = { "actions.open_cwd", mode = "n" },
					["`"] = { "actions.cd", mode = "n" },
					["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
					["gs"] = { "actions.change_sort", mode = "n" },
					["gx"] = "actions.open_external",
					["g."] = { "actions.toggle_hidden", mode = "n" },
					["g\\"] = { "actions.toggle_trash", mode = "n" },
				},

				use_default_keymaps = false,

				view_options = {
					show_hidden = true,
				},

				float = {
					border = "rounded",
					padding = 4,
					max_width = 120,
					max_height = 40,
					win_options = {
						winblend = 0,
					},
				},
			})

			vim.keymap.set("n", "-", function()
				if vim.bo.filetype == "oil" then
					-- Focus is on oil: close the sidebar
					vim.cmd("close")
				else
					-- Check if an oil window already exists in this tab
					for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
						local buf = vim.api.nvim_win_get_buf(win)
						if vim.bo[buf].filetype == "oil" then
							-- Oil is open but focus is on a file: jump to oil
							vim.api.nvim_set_current_win(win)
							return
						end
					end

					vim.cmd("botright vsplit")
					vim.cmd("vertical resize 30")
					require("oil").open()
				end
			end, { desc = "Toggle Oil sidebar" })
		end,
	},
}
