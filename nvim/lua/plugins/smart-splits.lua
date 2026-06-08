return {
	"mrjones2014/smart-splits.nvim",
	lazy = false,
	opts = {
		default_amount = 3, --
		ignored_filetypes = { "nofile", "quickfix", "prompt" }, --
	},
	config = function(_, opts)
		require("smart-splits").setup(opts)
		local map = vim.keymap.set

		-- Resizing splits (using Alt + hjkl)
		map("n", "<A-h>", require("smart-splits").resize_left, { desc = "Resize Left" })
		map("n", "<A-j>", require("smart-splits").resize_down, { desc = "Resize Down" })
		map("n", "<A-k>", require("smart-splits").resize_up, { desc = "Resize Up" })
		map("n", "<A-l>", require("smart-splits").resize_right, { desc = "Resize Right" }) --
	end,
}
