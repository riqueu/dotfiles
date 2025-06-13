return {
  "ellisonleao/glow.nvim",
  config = function()
    require("glow").setup({
      style = "dark",
      width = 120,
      height = 100,
    })
  end,
  cmd = "Glow",
}
