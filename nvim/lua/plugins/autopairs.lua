return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true, -- Enable Treesitter integration
				disable_filetype = { "TelescopePrompt" },
				fast_wrap = {
					map = "<M-e>", -- Alt-e to wrap a symbol in pairs quickly
					chars = { "{", "[", "(", '"', "'" },
					pattern = [=[[%'%"%)%>%]%]%}%,]]=],
					offset = 0,
					end_key = "$",
					keys = "qwertyuiopzxcvbnmasdfghjkl",
					check_comma = true,
					highlight = "PmenuSel",
					highlight_grey = "LineNr",
				},
			})
		end,
	},
}
