return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"jvgrootveld/telescope-zoxide",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					path_display = { "truncate " },
					file_ignore_patterns = { "^%.git/" },
					mappings = {
						i = {
							["<C-h>"] = function(prompt_bufnr)
								actions.select_horizontal(prompt_bufnr)
								vim.cmd("wincmd H") -- Move to the far left
							end,
							["<C-j>"] = function(prompt_bufnr)
								actions.select_horizontal(prompt_bufnr)
								vim.cmd("wincmd J") -- Move to the bottom
							end,
							["<C-k>"] = function(prompt_bufnr)
								actions.select_horizontal(prompt_bufnr)
								vim.cmd("wincmd K") -- Move to the top
							end,
							["<C-l>"] = function(prompt_bufnr)
								actions.select_horizontal(prompt_bufnr)
								vim.cmd("wincmd L") -- Move to the far right
							end,
						},
					},
				},

				pickers = {
					find_files = {
						hidden = true,
					},
				},
			})

			telescope.load_extension("fzf")

			-- Keymaps
			local builtin = require("telescope.builtin")

			local function search_config()
				builtin.find_files({
					cwd = vim.fn.stdpath("config"),
					prompt_title = "Config Files",
				})
			end

			vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Find Files" })

			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
			vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Find Symbols" })
			vim.keymap.set("n", "<leader>ws", builtin.lsp_dynamic_workspace_symbols, { desc = "Workspace Symbols" })
			vim.keymap.set("n", "<leader>fn", search_config, { desc = "Search Neovim Config" })
			vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })
			vim.keymap.set("n", "<leader>pz", require("telescope").extensions.zoxide.list)
		end,
	},
}
