require("nvim-autopairs").setup({
  check_ts = true,
  enable_afterquote = true,
  enable_moveright = true,
  enable_check_bracket_line = true,
  map_bs = true,
  map_c_h = false,  -- map the <C-h> key to delete a pair
  map_c_w = true,  -- map <c-w> to delete a pair if possible
})
