return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
        pickers = {
          live_grep = {
            file_ignore_patterns = { "node_modules", ".git", ".venv" },
            additional_args = function()
              return { "--hidden" }
            end,
          },
          find_files = {
            file_ignore_patterns = { "node_modules", ".git", ".venv" },
            hidden = true,
          },
        },
      })

      require("telescope").load_extension("ui-select")
    end,
  },
}
