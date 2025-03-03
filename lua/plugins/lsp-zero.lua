return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v3.x",
  lazy = false,

  config = function()
    local lsp_zero = require("lsp-zero")

    lsp_zero.extend_lspconfig()

    -- Diagnostics are not exclusive to LSP servers so these can be global keybings
    vim.keymap.set(
      "n",
      "<leader>cd",
      "<cmd>lua vim.diagnostic.open_float()<cr>",
      { desc = "Open diagnostics" }
    )
    vim.keymap.set(
      "n",
      "[d",
      "<cmd>lua vim.diagnostic.goto_next()<cr>",
      { desc = "Next diagnostic" }
    )
    vim.keymap.set(
      "n",
      "]d",
      "<cmd>lua vim.diagnostic.goto_prev()<cr>",
      { desc = "Previous diagnostic" }
    )
    lsp_zero.on_attach(function(_, bufnr)
      -- see :help lsp-zero-keybindings to learn the available actions
      -- K: Displays hover information about the symbol under the cursor in a
      -- gd: Jumps to the definition of the symbol under the cursor.
      -- gD: Jumps to the declaration of the symbol under the cursor. Some servers
      -- gi: Lists all the implementations for the symbol under the cursor in the
      -- go: Jumps to the definition of the type of the symbol under the cursor.
      -- gr:  Lists all the references to the symbol under the cursor in the quickfix
      -- gs: Displays signature information about the symbol under the cursor in a floating window.
      -- <F2>: Renames all references to the symbol under the cursor.
      -- <F3>: Format a buffer using the LSP servers attached to it.
      -- <F4>: Selects a code action available at the current cursor position.
      -- gl: Show diagnostic in a floating window.
      -- [d: Move to the previous diagnostic in the current buffer.
      -- ]d: Move to the next diagnostic.
      lsp_zero.default_keymaps({ buffer = bufnr })

      vim.keymap.set("n", "gD", function()
        vim.lsp.buf.declaration()
      end, { buffer = bufnr, remap = false, desc = "Go to declaration" })

      vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition()
      end, { buffer = bufnr, remap = false, desc = "Go to definition" })

      vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover()
      end, { buffer = bufnr, remap = false, desc = "Information about symbol" })

      vim.keymap.set("n", "<C-K>", function()
        vim.lsp.buf.signature_help()
      end, { buffer = bufnr, remap = false, desc = "Function signature help" })

      vim.keymap.set("n", "<leader>cs", function()
        vim.lsp.buf.implementation()
      end, { buffer = bufnr, remap = false, desc = "Go to implementation" })

      vim.keymap.set("n", "<leader>cs", function()
        vim.lsp.buf.workspace_symbol()
      end, { buffer = bufnr, remap = false, desc = "Search in workspace" })

      vim.keymap.set("n", "<leader>ca", function()
        vim.lsp.buf.code_action()
      end, { buffer = bufnr, remap = false, desc = "Code action" })

      vim.keymap.set("n", "<leader>cr", function()
        vim.lsp.buf.references()
      end, { buffer = bufnr, remap = false, desc = "Code references" })

      vim.keymap.set("n", "<leader>cn", function()
        vim.lsp.buf.rename()
      end, { buffer = bufnr, remap = false, desc = "Rename" })
    end)
  end,
}
