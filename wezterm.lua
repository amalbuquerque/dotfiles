
local wezterm = require("wezterm")

local config = {}

config = wezterm.config_builder()

config.color_scheme = "Catppuccin Macchiato"

config.font = wezterm.font_with_fallback({
{ family = "EnvyCodeR Nerd Font", scale = 1.2 },

{ family = "IosevkaTermSS10 Nerd Font", scale = 1.2 },
})

config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.default_workspace = "home"
config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 5,
}

return config
