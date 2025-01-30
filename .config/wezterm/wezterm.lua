local wezterm = require("wezterm")
local mappings = require("modules.mappings")

-- Show which key table is active in the status area
wezterm.on("update-right-status", function(window)
  local name = window:active_key_table()
  if name then
    name = "TABLE: " .. name
  end
  window:set_right_status(name or "")
end)

return {
  default_prog = { "powershell.exe", "-NoLogo" },
  default_cursor_style = "BlinkingBar",
  cursor_blink_rate = 500,
  animation_fps = 1,
  max_fps = 60,
  color_scheme = "Catppuccin Mocha",
  colors = {
    cursor_bg = "#A6ACCD",
    cursor_border = "#A6ACCD",
    cursor_fg = "#1B1E28",
  },
  -- font
  font = wezterm.font("JetBrains Mono", { weight = "Medium" }),
  font_size = 14,
  line_height = 1.0,
  window_background_opacity = 1.0,
  -- tab bar
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = false,
  hide_tab_bar_if_only_one_tab = true,
  tab_max_width = 999999,
  initial_cols = 90,
  initial_rows = 24,
  window_padding = {
    left = 5,
    right = 5,
    top = 5,
    bottom = 5,
  },
  window_decorations = "RESIZE",
  inactive_pane_hsb = {
    brightness = 0.7,
  },
  send_composed_key_when_left_alt_is_pressed = false,
  send_composed_key_when_right_alt_is_pressed = true,
  -- key bindings
  leader = mappings.leader,
  keys = mappings.keys,
  key_tables = mappings.key_tables,
}
