-- Autocommand to run biome lint on save with the `--unsafe` flag. This is needed to sort classes
-- automatically because the Biome useSortedClasses option is considered unsafe.
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

      vim.fn.system({ "bunx", "@biomejs/biome", "lint", file_path, "--unsafe" })
      local exit_code = vim.v.shell_error -- Get the exit code of the last command

      -- Check if there were any errors
      if exit_code == 0 then
        -- If no errors, run the format command
        vim.fn.system({ "bunx", "@biomejs/biome", "lint", file_path, "--write", "--unsafe" })

        -- Reload the buffer to reflect changes made by the command
        vim.cmd("edit")
      end
    end
  end,
})
