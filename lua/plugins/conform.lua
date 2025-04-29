local function has_prettier_config()
  local filepath = vim.fn.getcwd() .. "/.prettierrc"
  return vim.fn.filereadable(filepath) == 1
end

local biome_or_prettier = has_prettier_config() and { "prettierd" } or { "biome" }

return {
  "stevearc/conform.nvim",
  opts = {
    event = { "BufReadPre", "BufNewFile" },
    formatters_by_ft = {
      javascript = biome_or_prettier,
      typescript = biome_or_prettier,
      typescriptreact = biome_or_prettier,
      javascriptreact = biome_or_prettier,
      json = biome_or_prettier,
      html = { "prettierd" },
      css = biome_or_prettier,
      scss = { "prettierd" },
      markdown = { "prettierd" },
      yaml = { "yamlfix" },
      lua = { "stylua" },
      bash = { "shfmt" },
      sh = { "shfmt" },
      python = { "black" },
      graphql = biome_or_prettier,
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
