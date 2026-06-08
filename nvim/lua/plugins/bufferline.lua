return {
	{
		"famiu/bufdelete.nvim",
		event = "VeryLazy",
		config = function()
			vim.keymap.set("n", "<leader>bc", "<cmd>Bdelete<CR>", { desc = "Close Buffer" })
		end,
	},
}
