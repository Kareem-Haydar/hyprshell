local function update_telescope_highlights()
    local colors = {
        ["default"] = {
            prompt_highlight = "#ff9e64",
            results_highlight = "#56b6c2",
            preview_highlight = "#c678dd",
            prompt_text = "#3e4452",
            results_text = "#3e4452",
            preview_text = "#3e4452",
            bg = "#3d3d3d"
        },
        ["gruvbox-material"] = {
            prompt_highlight = "#ff9e64",
            results_highlight = "#56b6c2",
            preview_highlight = "#c678dd",
            prompt_text = "#282828",
            results_text = "#282828",
            preview_text = "#282828",
            bg = "#323232"
        },
        ["kanagawa"] = {
            prompt_highlight = "#649da9",
            results_highlight = "#647aa9",
            preview_highlight = "#7164a9",
            prompt_text = "#1f1f28",
            results_text = "#1f1f28",
            preview_text = "#1f1f28",
            bg = "#2a2a32"
        },
        ["catppuccin-mocha"] = {
            prompt_highlight = "#ff9e64",
            results_highlight = "#56b6c2",
            preview_highlight = "#c678dd",
            prompt_text = "#1e1e2e",
            results_text = "#1e1e2e",
            preview_text = "#1e1e2e",
            bg = "#292938"
        },
        ["tokyonight-moon"] = {
            prompt_highlight = "#ff9e64",
            results_highlight = "#56b6c2",
            preview_highlight = "#c678dd",
            prompt_text = "#222436",
            results_text = "#222436",
            preview_text = "#222436",
            bg = "#2d2e40"
        },
        ["cyberdream"] = {
            prompt_highlight = "#2b99d4",
            results_highlight = "#2bd4bb",
            preview_highlight = "#2bd466",
            prompt_text = "#16181a",
            results_text = "#16181a",
            preview_text = "#16181a",
            bg = "#212325"
        },
        ["github_dark"] = {
            prompt_highlight = "#3495bc",
            results_highlight = "#3452bc",
            preview_highlight = "#5b34bc",
            prompt_text = "#30363d",
            results_text = "#30363d",
            preview_text = "#30363d",
            bg = "#3a4046"
        },
        ["vscode"] = {
            prompt_highlight = "#70fee8",
            results_highlight = "#70ccfe",
            preview_highlight = "#7085fe",
            prompt_text = "#232136",
            results_text = "#232136",
            preview_text = "#232136",
            bg = "#2a2a2a"
        },
        ["rose-pine"] = {
            prompt_highlight = "#5362ac",
            results_highlight = "#ac5362",
            preview_highlight = "#62ac53",
            prompt_text = "#1f1f1f",
            results_text = "#1f1f1f",
            preview_text = "#1f1f1f",
            bg = "#2e2c40"
        },
        ["rosebones"] = {
            prompt_highlight = "#2d6781",
            results_highlight = "#2d3D81",
            preview_highlight = "#2d8171",
            prompt_text = "#1f1f1f",
            results_text = "#1f1f1f",
            preview_text = "#1f1f1f",
            bg = "#191723"
        },
        ["onedark"] = {
            prompt_highlight = "#b06ec6",
            results_highlight = "#c6b06e",
            preview_highlight = "#6ec6b0",
            prompt_text = "#262A31",
            results_text = "#262A31",
            preview_text = "#262A31",
            bg = "#262a31"
        },
        ["base16-black-metal-gorgoroth"] = {
            prompt_highlight = "#5f8787",
            results_highlight = "#8c7f70",
            preview_highlight = "#aaaaab",
            prompt_text = "#262A31",
            results_text = "#262A31",
            preview_text = "#262A31",
            bg = "#000000"
        },
        ["zenbones"] = {
            prompt_highlight = "#716966",
            results_highlight = "#8c7f70",
            preview_highlight = "#aaaaab",
            prompt_text = "#262A31",
            results_text = "#262A31",
            preview_text = "#262A31",
            bg = "#171512"
        },
        ["ayu"] = {
            prompt_highlight = "#e6b450",
            results_highlight = "#e67e50",
            preview_highlight = "#e6d450",
            prompt_text = "#262a31",
            results_text = "#262a31",
            preview_text = "#262a31",
            bg = "#171512"
        },
        ["onedark_dark"] = {
            prompt_highlight = "#e6b450",
            results_highlight = "#e06c75",
            preview_highlight = "#c678dd",
            prompt_text = "#1e2024",
            results_text = "#1e2024",
            preview_text = "#1e2024",
            bg = "NONE"
        },
        -- Add other colorschemes and their colors...
    }

    local scheme = vim.g.colors_name or "default"
    local color = colors[scheme] or colors["default"]

    vim.cmd(string.format(
      [[
        highlight TelescopePromptTitle guifg=%s guibg=%s gui=bold
        highlight TelescopeResultsTitle guifg=%s guibg=%s gui=bold
        highlight TelescopePreviewTitle guifg=%s guibg=%s gui=bold
        highlight TelescopeBorder guibg=%s
        highlight TelescopePromptBorder guibg=%s
        highlight TelescopeResultsBorder guibg=%s
        highlight TelescopePreviewBorder guibg=%s
        highlight TelescopePromptNormal guibg=%s
        highlight TelescopeResultsNormal guibg=%s
        highlight TelescopePreviewNormal guibg=%s
        highlight TelescopePromptPrefix guibg=%s       
    ]],
      color.prompt_text, color.prompt_highlight, color.results_text, color.results_highlight, color.preview_text, color.preview_highlight, color.bg, color.bg, color.bg, color.bg, color.bg, color.bg, color.bg, color.bg
    ))
end

-- Call the function initially to set the highlights
update_telescope_highlights()

-- Set up an autocmd to update highlights when a colorscheme is applied
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        update_telescope_highlights()
    end,
})

vim.opt.fillchars = { eob = ' ' }
