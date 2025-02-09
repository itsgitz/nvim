return {
  "tokyonight.nvim",
  opts = {
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    on_highlights = function(highlights, colors)
      highlights.DiagnosticUnnecessary.fg = "#709fba"
      highlights.LineNr.fg = "#669afa"
      highlights.CursorLineNr.fg = "#ffffff"
    end,
  },
}
