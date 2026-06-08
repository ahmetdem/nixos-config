return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			scroll = { enabled = true },
			image = {
				enabled = true,
				formats = { "png", "jpg", "jpeg", "gif", "webp" },
			},

			bigfile = { enabled = true },
			quickfile = { enabled = true },
			words = { enabled = true },
		},
	},
}
