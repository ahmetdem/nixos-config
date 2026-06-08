return {
	"nvim-treesitter/nvim-treesitter",
	version = false,
	build = ":TSUpdate",
	-- event = { "BufReadPost", "BufNewFile" },
	lazy = false,
	main = "nvim-treesitter.configs",
	branch = "master",
	opts = {
		ensure_installed = {
			"lua",
			"vim",
			"vimdoc",
			"query",
			"python",
			"c",
			"cpp",
			"markdown",
			"markdown_inline",
			"csv",
			"json",
			"go",
			"javascript",
			"typescript",
			"c_sharp",
      "matlab"
		},
		auto_install = true,
		highlight = { enable = true },
		indent = { enable = true },
	},

	-- Fallback config to handle edge cases
	config = function(_, opts)
		local status_ok, configs = pcall(require, "nvim-treesitter.configs")
		if not status_ok then
			return
		end

		configs.setup(opts)
	end,
}
