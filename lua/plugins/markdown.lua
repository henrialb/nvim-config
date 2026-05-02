return {
  enabled = true,
  "brianhuster/live-preview.nvim",
  dependencies = {
    "folke/snacks.nvim",
  },
  config = function()
    vim.keymap.set(
      "n",
      "<leader>ms",
      ":LivePreview start<CR>",
      { desc = "Markdown Live Preview Start" }
    )
    vim.keymap.set(
      "n",
      "<leader>mq",
      ":LivePreview close<CR>",
      { desc = "Markdown Live Preview Stop" }
    )
  end,
}
