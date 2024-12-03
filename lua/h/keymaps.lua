-- Replace the highlighted word
vim.keymap.set(
  "n",
  "<leader>r",
  [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]],
  { desc = "Replace highlighted word" }
)
