return {
  "nvim-treesitter/nvim-treesitter",
  opts = function()
    require("nvim-treesitter.configs").setup({
      highlight = {
        enable = true,
      },
    })
  end,
}
