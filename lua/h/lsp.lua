-- This should be executed before you configure any language server
local lspconfig_defaults = require("lspconfig").util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  "force",
  lspconfig_defaults.capabilities,
  require("cmp_nvim_lsp").default_capabilities()
)

require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {
    "ts_ls",
    "lua_ls",
    "eslint",
    "ruby_lsp",
    "tailwindcss",
    "biome",
  },
  handlers = {
    -- Setup language servers
    vim.lsp.config.biome.setup({}),
    require("lspconfig").eslint.setup({}),
    require("lspconfig").jsonls.setup({}),
    require("lspconfig").cssls.setup({}),

    require("lspconfig").tailwindcss.setup({
      settings = {
        tailwindCSS = {
          validate = true,
          classAttributes = { "class", "className", ".*Classes.*" },
          experimental = {
            classRegex = {
              { "(?:twMerge|twJoin|tv)\\(([^\\);]*)[\\);]", "[`'\"]([^'\"`,;]*)[`'\"]" },
            },
          },
        },
      },
    }),

    require("lspconfig").lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    }),

    require("lspconfig").ts_ls.setup({
      init_options = {
        preferences = {
          disableSuggestions = true,
        },
      },
    }),

    require("lspconfig").ruby_lsp.setup({
      mason = false,
      cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") },
    }),

    require("lspconfig").rubocop.setup({
      mason = false,
      cmd = { vim.fn.expand("~/.rbenv/shims/rubocop"), "--lsp" },
    }),
  },
})

vim.opt.signcolumn = "yes"

-- This is where you enable features that only work if there is a language server active in the
-- file
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local opts = { buffer = event.buf }

    -- Helper function to merge options with a description
    local function with_desc(desc)
      return vim.tbl_extend("force", {}, opts, { desc = desc })
    end

    vim.keymap.set(
      "n",
      "K",
      "<cmd>lua vim.lsp.buf.hover()<cr>",
      with_desc("Information about symbol")
    )
    vim.keymap.set(
      "n",
      "gd",
      "<cmd>lua vim.lsp.buf.definition()<cr>",
      with_desc("Go to definition")
    )
    vim.keymap.set(
      "n",
      "gD",
      "<cmd>lua vim.lsp.buf.declaration()<cr>",
      with_desc("Go to declaration")
    )
    vim.keymap.set(
      "n",
      "<leader>ci",
      "<cmd>lua vim.lsp.buf.implementation()<cr>",
      with_desc("Go to implementation")
    )
    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", with_desc(""))
    vim.keymap.set(
      "n",
      "<leader>cr",
      "<cmd>lua vim.lsp.buf.references()<cr>",
      with_desc("Code references")
    )
    vim.keymap.set(
      "i",
      "<C-K>",
      "<cmd>lua vim.lsp.buf.signature_help()<cr>",
      with_desc("Function signature help")
    )
    vim.keymap.set("n", "<leader>cn", "<cmd>lua vim.lsp.buf.rename()<cr>", with_desc("Rename"))
    vim.keymap.set(
      "n",
      "<leader>ca",
      "<cmd>lua vim.lsp.buf.code_action()<cr>",
      with_desc("Code action")
    )
    vim.keymap.set(
      { "n", "x" },
      "<leader>cf",
      "<cmd>lua vim.lsp.buf.format({async = true})<cr>",
      with_desc("Format buffer")
    )
  end,
})
