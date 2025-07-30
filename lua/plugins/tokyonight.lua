return {
  "tokyonight.nvim",
  opts = {
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    on_highlights = function(hl, c)
      hl.LineNr = { fg = "#7aa2f7" }
      hl.CursorLineNr = { fg = "#e0af68", bold = true }
    end,
  },
}
