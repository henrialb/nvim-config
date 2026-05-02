-- Autocommand to run biome check on save with the `--unsafe` flag. This handles linting,
-- import sorting, and class sorting (useSortedClasses is considered unsafe by biome).
vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function()
    -- Check if the Biome LSP is active for the current buffer
    local clients = vim.lsp.get_clients()
    local biome_lsp_active = false

    for _, client in ipairs(clients) do
      if client.name == "biome" and client.attached_buffers[vim.fn.bufnr()] then
        biome_lsp_active = true
        break
      end
    end

    if biome_lsp_active then
      local file_path = vim.fn.expand("%:p") -- Get the full path of the current file
      local runner = "pnpx"

      -- Detect package manager by lockfile
      -- local project_root = vim.fn.fnamemodify(file_path, ":h")
      -- if vim.fn.findfile("bun.lock", project_root .. ";") ~= "" then
      --   runner = "bunx"
      -- end

      -- Run from the biome project root to avoid CWD being treated as an implicit root by Biome
      local biome_client = vim.lsp.get_clients({ name = "biome", bufnr = vim.fn.bufnr() })[1]
      local project_root = biome_client.root_dir

      vim.fn.jobstart(
        { runner, "@biomejs/biome", "check", file_path, "--write", "--unsafe" },
        {
          cwd = project_root,
          on_exit = function()
            vim.schedule(function()
              vim.cmd("checktime")
            end)
          end,
        }
      )
    end
  end,
})
