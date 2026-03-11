return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "lua",
      "python",
      "c",
      "bash",
      "vim",
      "vimdoc",
      "query",
      "markdown",
      "markdown_inline",
    },
    highlight = { enable = true },
    indent = { enable = true },
  },
}
