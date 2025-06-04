local M = {}

-- Regex patterns
local patterns = {
    hex = "#%x%x%x%x%x%x",
    rgb = "rgb%(%s*%d+%s*,%s*%d+%s*,%s*%d+%s*%)",
    rgba = "rgba%(%s*%d+%s*,%s*%d+%s*,%s*%d+%s*,%s*[%d%.]+%s*%)"
}

-- Function to parse current buffer
function M.extract_colors()
    local bufnr = vim.api.nvim_get_current_buf()
    local filepath = vim.api.nvim_buf_get_name(bufnr)

    if filepath == "" then
        print("No file open.")
        return
    end

    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local matches = {}

    for _, line in ipairs(lines) do
        for name, pattern in pairs(patterns) do
            for match in line:gmatch(pattern) do
                table.insert(matches, match)
            end
        end
    end

    if #matches == 0 then
        print("No colors found.")
    else
        print("Found colors:")
        for _, color in ipairs(matches) do
            print("  " .. color)
        end
    end
end

-- Optional command to call it easily
vim.api.nvim_create_user_command("ExtractColors", function()
    M.extract_colors()
end, {})

return M

