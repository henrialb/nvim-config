return {
  "stevearc/conform.nvim",
  opts = {
    event = { "BufReadPre", "BufNewFile" },
    formatters_by_ft = {
      javascript = { "biome", "prettierd", stop_after_first = true },
      typescript = { "biome", "prettierd", stop_after_first = true },
      typescriptreact = { "biome", "prettierd", stop_after_first = true },
      javascriptreact = { "biome", "prettierd", stop_after_first = true },
      json = { "biome", "prettierd", stop_after_first = true },
      html = { "prettierd" },
      css = { "biome", "prettierd", stop_after_first = true },
      scss = { "prettierd" },
      markdown = { "prettierd" },
      yaml = { "yamlfix" },
      lua = { "stylua" },
      bash = { "shfmt" },
      sh = { "shfmt" },
      python = { "black" },
      graphql = { "biome", "prettierd", stop_after_first = true },
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
  },
}
