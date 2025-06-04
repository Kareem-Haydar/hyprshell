require('neo-tree').setup({
    filesystem = {
        filtered_items = {
            hide_gitignored = false,  -- Disable hiding gitignored files
            hide_dotfiles = false,    -- Optionally, disable hiding dotfiles
            hide_by_name = {
                -- Add any specific files you want to hide by name
            },
            never_show = {
                -- Add any specific files you never want to show
            },
        },
    },
})

vim.keymap.set('n', '<c-n>', function ()
  vim.cmd[[ Neotree toggle=true ]]
end, { silent = true })
