return {
    {
        "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp" },
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf }
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                end,
            })

            vim.lsp.config("*", { capabilities = capabilities })

            vim.lsp.config("clangd", {
                cmd = {
                    "clangd",
                    "--query-driver=/usr/bin/gcc,/usr/bin/g++",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=never",
                },
            })

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = { diagnostics = { globals = { "vim" } } },
                },
            })

            vim.lsp.config("pyright", {
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = "workspace",
                        },
                    },
                },
            })

            vim.lsp.enable({
                "clangd",
                "lua_ls",
                "pyright",
                "ts_ls",
                "bashls",
                "zls",
                "marksman",
                "nixd",
                "ols",
            })
        end,
    },
}
