return {
  "tokyonight.nvim",
  opts = {
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    on_highlights = function(hl, c)
      hl.DiagnosticUnnecessary = {
        fg = c.dark5,
      }
    end,
  },
}
