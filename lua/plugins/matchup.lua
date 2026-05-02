-- Smarter '%'
return {
  "andymass/vim-matchup",
  config = function()
    vim.g.matchup_matchparen_offscreen = { method = "popup" }
    -- TODO: remove when Neovim fixes the vim.range bug (nvim 0.12.2)
    vim.g.matchup_treesitter_enabled = false
  end,
}
