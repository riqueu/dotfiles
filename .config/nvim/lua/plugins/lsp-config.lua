return {
  "neovim/nvim-lspconfig",
  lazy = false,
  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_nvim_lsp.default_capabilities()
    )

    -- configure servers
    vim.lsp.config("clangd", {
      capabilities = capabilities,
    })

    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
    })

    vim.lsp.config("pylsp", {
      capabilities = capabilities,
    })

    vim.lsp.config("julials", {
      capabilities = capabilities,
    })

    -- enable servers
    vim.lsp.enable({
      "clangd",
      "lua_ls",
      "pylsp",
      "julials",
    })

    -- keymaps when LSP attaches
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, opts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
      end,
    })
  end,
}
