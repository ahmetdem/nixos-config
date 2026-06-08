return {
	{
		"saghen/blink.cmp",
		version = "*",
		opts = {
			keymap = {
				preset = "default",
				["<CR>"] = { "accept", "fallback" },

				-- Tab navigation
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },

				-- Keep these for accessibility
				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
			},

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},

			-- "Batteries included" sources
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			signature = { enabled = true },

			completion = {
				list = { selection = { preselect = true, auto_insert = true } },
				menu = { border = "rounded" },
			},
		},
	},
}
