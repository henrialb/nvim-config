-- Cursor
vim.o.guicursor = table.concat({
  "n-v-c:block-Cursor/lCursor",
  "i-ci:ver25/lCursor-blinkwait1000-blinkon100-blinkoff100",
  "r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100",
}, ",")
