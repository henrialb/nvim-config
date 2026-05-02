local function get_formatter(bufnr)
  local filepath = vim.api.nvim_buf_get_name(bufnr)
  local dir = vim.fn.fnamemodify(filepath, ":h")
  local has_prettier = vim.fn.findfile(".prettierrc", dir .. ";") ~= ""
    or vim.fn.findfile(".prettierrc.js", dir .. ";") ~= ""
    or vim.fn.findfile(".prettierrc.json", dir .. ";") ~= ""
    or vim.fn.findfile("prettier.config.js", dir .. ";") ~= ""
  return has_prettier and { "prettierd" } or { "biome" }
end

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      javascript = function(bufnr)
        return get_formatter(bufnr)
      end,
      typescript = function(bufnr)
        return get_formatter(bufnr)
      end,
      typescriptreact = function(bufnr)
        return get_formatter(bufnr)
      end,
      javascriptreact = function(bufnr)
        return get_formatter(bufnr)
      end,
      json = function(bufnr)
        return get_formatter(bufnr)
      end,
      css = function(bufnr)
        return get_formatter(bufnr)
      end,
      graphql = function(bufnr)
        return get_formatter(bufnr)
      end,
      html = function(bufnr)
        return get_formatter(bufnr)
      end,
      scss = { "prettierd" },
      markdown = { "prettierd" },
      yaml = { "yamlfix" },
      lua = { "stylua" },
      bash = { "shfmt" },
      sh = { "shfmt" },
      python = { "black" },
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
      lsp_format = "fallback",
      async = false,
      timeout_ms = 1000,
    },
  },
}
