return {
    {
        "linux-cultist/venv-selector.nvim",
        dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
        ft = "python",
        opts = {
            settings = {
                options = {
                    notify_user_on_venv_activation = true,
                },
            },
        },
        keys = {
            { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
        },
    },
}
