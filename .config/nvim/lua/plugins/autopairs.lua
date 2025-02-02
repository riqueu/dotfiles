return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end
  }
}
