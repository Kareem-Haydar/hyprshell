require("codeium").setup({
  enable_chat = true,
  enable_cmp_source = false,
  virtual_text = {
    enabled = true,
    manual = false,
    idle_delay = 10,
    filetypes = {
      "c", "cpp", "rs", "zig", "py", "js", "toml", "sh", "conf", "rasi", "yuck", "html", "css", "scss", "ts"
    },
    key_bindings = {
      accept = "<c-a>",
      next = "<c-]>",
      prev = "<c-[",
    }
  },
})
