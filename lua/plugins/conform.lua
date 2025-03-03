return {
  "stevearc/conform.nvim",
  opts = {
    event = { "BufReadPre", "BufNewFile" },
    formatters_by_ft = {
      javascript = { "biome", "prettierd" },
      typescript = { "biome", "prettierd" },
      typescriptreact = { "biome", "prettierd" },
      javascriptreact = { "biome", "prettierd" },
      json = { "biome", "prettierd" },
      html = { "prettierd" },
      css = { "biome", "prettierd" },
      scss = { "prettierd" },
      markdown = { "prettierd" },
      yaml = { "yamlfix" },
      lua = { "stylua" },
      bash = { "shfmt" },
      sh = { "shfmt" },
      python = { "black" },
      graphql = { "biome", "prettierd" },
      eruby = { "erb_format" },
    },

    formatters = {
      yamlfix = {
        env = {
          YAMLFIX_SEQUENCE_STYLE = "block_style",
          YAMLFIX_SECTION_WHITELINES = "1",
          YAMLFIX_LINE_LENGTH = "100",
          YAMLFIX_preserve_quotes = "true",
        },
      },
    },

    format_on_save = {
      lsp_fallback = true,
      async = false,
      timeout_ms = 1000,
    },

    stop_after_first = true,
  },
}
