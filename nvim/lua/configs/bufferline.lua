require("bufferline").setup{
 highlights = {
    fill = {
      bg = "NONE", -- transparent background
    },
    background = {
      bg = "NONE", -- transparent area around inactive tabs
    },
    tab = {
      fg = "#888888", -- dim color for tab label
      bg = "#5f87af",
    },
    tab_selected = {
      fg = "#ffffff", -- bright color for selected tab
      bg = "#5f87af", -- give selected tab a background color
      bold = true,
    },
    tab_separator = {
      fg = "#5f87af", -- separator color
      bg = "NONE",
    },
    tab_separator_selected = {
      fg = "#5f87af",
      bg = "#5f87af", -- matches selected tab bg for visual continuity
    },
    buffer_selected = {
      fg = "#ffffff",
      bg = "#5f87af",
      bold = true,
    },
    buffer_visible = {
      fg = "#bbbbbb",
      bg = "NONE",
    },
    buffer = {
      fg = "#888888",
      bg = "NONE",
    },
    separator = {
      fg = "#5f87af",
      bg = "NONE",
    },
    separator_selected = {
      fg = "#5f87af",
      bg = "#5f87af",
    },
    separator_visible = {
      fg = "#5f87af",
      bg = "NONE",
    },
  },
  options = {
    separator_style = "slant"
  },
}
