local colorscheme = "onedark"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
require('onedark').setup {
  -- style = 'light',
  -- toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between
  toggle_style_list = { 'dark', 'light' }, -- List of styles to toggle between
}
