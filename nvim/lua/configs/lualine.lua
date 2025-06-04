local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

local function get_cwd()
  local cwd = vim.fn.getcwd()
  return " " .. vim.fn.fnamemodify(cwd, ':t')
end

local function get_current_file()
  local current_buf = vim.api.nvim_get_current_buf()
  local current_file = vim.api.nvim_buf_get_name(current_buf)
  local file_name = vim.fn.fnamemodify(current_file, ":t")

  -- Check if the buffer is modified
  local is_modified = vim.api.nvim_buf_get_option(current_buf, 'modified')

  if file_name ~= "" and file_name ~= "NvimTree_1" then
    if is_modified then
      return file_name .. "*"
    else
      return file_name
    end
  else
    return ""
  end
end

local function get_buffer_progress()
  -- Get the current line number
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local current_buf = vim.api.nvim_get_current_buf()
  local current_file = vim.api.nvim_buf_get_name(current_buf)
  local file_name = vim.fn.fnamemodify(current_file, ":t")

  if file_name == "" then
    return ""
  end

  -- Get the total number of lines in the current buffer
  local total_lines = vim.api.nvim_buf_line_count(0)

  -- Calculate the progress as a percentage
  local progress = math.floor((current_line / total_lines) * 100)

  if progress == 100 then
    return " Bot"
  end

  if progress == 0 then
    return " Top"
  end

  -- Format the progress
  return " " .. string.format("%.0f", progress) .. ""
end

-- Utility function to lighten a hex color by a given percentage
local function lighten_hex_color(hex_color, percent)
  local r = tonumber(hex_color:sub(2, 3), 16)
  local g = tonumber(hex_color:sub(4, 5), 16)
  local b = tonumber(hex_color:sub(6, 7), 16)
  r = math.floor(r + (255 - r) * percent)
  g = math.floor(g + (255 - g) * percent)
  b = math.floor(b + (255 - b) * percent)
  return string.format("#%02x%02x%02x", r, g, b)
end

-- Function to get Neovim background color and return a lighter version
local function get_lighter_bg_color()
  local bg_color = vim.api.nvim_get_hl_by_name('Normal', true)['background']

  -- Convert color to hex
  local hex_color = string.format("#%06x", bg_color)

  -- Lighten the color by 10%
  local lighter_color = lighten_hex_color(hex_color, 0.05)

  return lighter_color
end

local function get_active_lsp()
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
        return ''
    end
    local msg = "  LSP ~ "
    for _, client in ipairs(clients) do
        msg = msg .. client.name .. ' '
    end
    return msg
end

require('lualine').setup {
  options = {
    globalstatus = true,
    theme = 'auto',
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { { 'mode', separator = { right = '' } } },
    lualine_b = { { 'filetype', 'branch', separator = { right = '' } } },
    lualine_c = {
      '%=', --[[ add your center compoentnts here in place of this comment ]]
    },
    lualine_x = { 'diagnostics', get_active_lsp },
    lualine_y = { get_buffer_progress, get_current_file },
    lualine_z = {
      { get_cwd, separator = { left = '' } },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}
