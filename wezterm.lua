local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Default to WSL Ubuntu opening in user profile
config.default_prog = { 'wsl.exe', '--cd', '/mnt/c/Users/parke', '-d', 'Ubuntu' }

-- Font
config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.font_size = 11.5

-- Appearance: Theme, Transparency, Blur
config.color_scheme = 'Tokyo Night'
config.window_background_image = 'C:/Users/parke/wezterm_bg.jpg'
config.window_background_image_hsb = {
  brightness = 0.2, -- Darken for text readability
  hue = 1.0,
  saturation = 1.0,
}
config.window_background_opacity = 0.85
config.win32_system_backdrop = 'Acrylic' -- Windows specific blur

-- Window & Tabs
config.window_decorations = "RESIZE" -- Removes title bar for cleaner look
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

-- Padding
config.window_padding = {
  left = 12,
  right = 12,
  top = 12,
  bottom = 12,
}

-- Cursor
config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_rate = 500

return config
