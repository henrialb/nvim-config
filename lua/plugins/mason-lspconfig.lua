return {
  "williamboman/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      "tsserver",
      "lua_ls",
      "eslint",
      "ruby_ls",
    },
    handlers = {
      require("lsp-zero").default_setup,

      lua_ls = function()
        local lua_opts = require("lsp-zero").nvim_lua_ls()
        require("lspconfig").lua_ls.setup(lua_opts)
      end,
    },
  }
}
