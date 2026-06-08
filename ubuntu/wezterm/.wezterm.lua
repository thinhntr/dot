local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Macchiato (Gogh)"

local catppuccin_moon = wezterm.color.get_builtin_schemes()["Catppuccin Macchiato (Gogh)"]
catppuccin_moon.background = wezterm.color.get_builtin_schemes()["Rosé Pine Moon (Gogh)"].background
config["color_schemes"] = {
	catppuccin_moon = catppuccin_moon,
}
config.color_scheme = "catppuccin_moon"

config.font = wezterm.font("JetBrainsMonoNL Nerd Font Mono")
config.font_size = 16

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

return config
