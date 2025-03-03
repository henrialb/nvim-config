-- Autocommand to run biome lint on save. This is needed to sort classes automatically because the
-- Biome useSortedClasses option is considered unsafe
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = {
    "*.astro",
    "*.css",
    "*.graphql",
    "*.js",
    "*.jsx",
    "*.json",
    "*.jsonc",
    "*.svelte",
    "*.ts",
    "*.tsx",
    "*.vue",
  },
  callback = function()
    local file_path = vim.fn.expand("%:p") -- Get the full path of the current file
    local project_root = vim.fn.fnamemodify(file_path, ":h") -- Get the directory of the current file
    local biome_config_file = project_root .. "/biome.json" -- Adjust this if your config file is named differently

    -- Check if the biome configuration file exists
    if vim.fn.filereadable(biome_config_file) then
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
