return {
  "jakobkhansen/journal.nvim",
  config = function()
    local template = [[
    ---
    layout: post
    title: "%Y %B %d"
    categories: Blog
    ---
    ]]
    require("journal").setup({
      root = "~/Documents/journal",
      journal = {
        format = "%Y/%m/%Y-%m-%d-post",
        frequency = { day = 1 },
        template = template,
      },
    })
  end,
}
