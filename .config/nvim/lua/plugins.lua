lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

require("lazy").setup({
    { 'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' } },
    -- theme
    { "catppuccin/nvim",        name = "catppuccin" },
    --
    {
        'nvim-treesitter/nvim-treesitter',
        cmd = 'TSUpdate'
    },

    {
        'VonHeikemen/lsp-zero.nvim',
        dependencies = {
            -- LSP Support
            'neovim/nvim-lspconfig', -- Required
            'williamboman/mason.nvim', -- Optional
            'williamboman/mason-lspconfig.nvim', -- Optional

            -- Autocompletion
            'hrsh7th/nvim-cmp', -- Required
            'hrsh7th/cmp-nvim-lsp', -- Required
            'hrsh7th/cmp-buffer', -- Optional
            'hrsh7th/cmp-path', -- Optional
            'saadparwaiz1/cmp_luasnip', -- Optional
            'hrsh7th/cmp-nvim-lua', -- Optional

            -- Snippets
            'L3MON4D3/LuaSnip', -- Required
            'rafamadriz/friendly-snippets', -- Optional
        }
    },

    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },

    { 'vim-airline/vim-airline' },

    {'romgrk/barbar.nvim', dependencies = 'nvim-tree/nvim-web-devicons'},

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    },
})
--
