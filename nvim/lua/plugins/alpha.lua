return {
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			-- 1. Custom Header with Padding
			dashboard.section.header.val = {
				[[                                  ]],
				[[                                  ]],
				"███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
				"████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
				"██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
				"██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
				"██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
				"╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
				[[                                  ]],
			}

			-- 2. Refined Buttons with Key Tooltips
			dashboard.section.buttons.val = {
				dashboard.button("p", "󱔗  Projects", ":Telescope zoxide list<CR>"),
				dashboard.button("f", "  Find File", ":Telescope find_files <CR>"),
				dashboard.button("r", "  Recent Files", ":Telescope oldfiles <CR>"),
				dashboard.button("n", "  New File", ":ene <BAR> startinsert <CR>"),
				dashboard.button("c", "  Config", ":e $MYVIMRC <CR>"),
				dashboard.button("u", "󰚰  Update", ":Lazy sync<CR>"),
				dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
			}

			dashboard.section.buttons.opts.spacing = 0

			-- 3. Dynamic Footer
			local stats = require("lazy").stats()
			local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
			dashboard.section.footer.val = "󱐌 " .. stats.count .. " plugins loaded in " .. ms .. "ms"

			-- 4. Cyberdream Aesthetic: Apply Highlighting
			-- We set these groups; make sure your theme or init.lua defines them
			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.buttons.opts.hl = "AlphaButtons"
			dashboard.section.footer.opts.hl = "AlphaFooter"

			-- 5. Layout Setup
			-- This adds spacing between the header, buttons, and footer
			dashboard.config.layout = {
				{ type = "padding", val = 2 },
				dashboard.section.header,
				{ type = "padding", val = 2 },
				dashboard.section.buttons,
				{ type = "padding", val = 1 },
				dashboard.section.footer,
			}

			alpha.setup(dashboard.opts)

			-- Disable folding and line numbers on dashboard
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "alpha",
				callback = function()
					vim.opt_local.number = false
					vim.opt_local.relativenumber = false
					vim.opt_local.cursorline = false
				end,
			})
		end,
	},
}
