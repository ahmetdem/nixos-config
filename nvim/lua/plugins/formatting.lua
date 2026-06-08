return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					zig = { "zigfmt" },
					lua = { "stylua" },
					python = { "isort", "black" },
					c = { "clang-format" },
					cpp = { "clang-format" },
					go = { "goimports", "gofumpt" },
					nix = { "nixfmt" },
				},
			})

			vim.keymap.set({ "n", "v" }, "<leader>f", function()
				require("conform").format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				})
			end, { desc = "Format file" })
		end,
	},
}
