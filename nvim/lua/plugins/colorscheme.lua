return {
	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("cyberdream").setup({
				transparent = true,
			})
			vim.cmd.colorscheme("cyberdream")

			local cyber_blue = "#5fffe0"
			vim.api.nvim_set_hl(0, "FloatBorder", { fg = cyber_blue })
			vim.api.nvim_set_hl(0, "AlphaHeader", { fg = cyber_blue })
			vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#ffffff" })
			vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#1e3a3f", italic = true })
		end,
	},
}
