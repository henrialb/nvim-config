-- Use Enter to add new lines above and below
vim.keymap.set("n", "<CR>", "m`o<Esc>``")
vim.keymap.set("n", "<M-CR>", "m`O<Esc>``")

-- Diganostics
vim.keymap.set(
  "n",
  "<leader>cd",
  "<cmd>lua vim.diagnostic.open_float()<cr>",
  { desc = "Open diagnostics" }
)
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_next()<cr>", { desc = "Next diagnostic" })
vim.keymap.set(
  "n",
  "]d",
  "<cmd>lua vim.diagnostic.goto_prev()<cr>",
  { desc = "Previous diagnostic" }
)

-- Replace the highlighted word
vim.keymap.set(
  "n",
  "<leader>r",
  [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]],
  { desc = "Replace highlighted word" }
)
