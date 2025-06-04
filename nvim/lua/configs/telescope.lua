require("telescope").setup({
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({
        layout_strategy = "cursor",
        borderchars = { prompt = { " ", " ", " ", " ", " ", " ", " ", " " }, results = { " ", " ", " ", " ", " ", " ", " ", " " }, preview = { " ", " ", " ", " ", " ", " ", " ", " " }, },
      }),
    },
  },
  defaults = {
    borderchars = { prompt = { " ", " ", " ", " ", " ", " ", " ", " " }, results = { " ", " ", " ", " ", " ", " ", " ", " " }, preview = { " ", " ", " ", " ", " ", " ", " ", " " }, },
    border = true,
    prompt_prefix = "󰍉 ",
    selection_caret = "> ",
    layout_config = {},
  },
})


require("telescope").load_extension("ui-select")
require("telescope").load_extension("project")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>bf", ":Telescope file_browser<CR>")
vim.keymap.set("n", "<leader>fp", function()
  require'telescope'.extensions.project.project{}
end, {})
