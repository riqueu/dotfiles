local wezterm = require("wezterm")
local act = wezterm.action

return {
  leader = { key = "F1", mods = "SHIFT" },

  keys = {
    -- spawn and kill tab
    {
      key = "w",
      mods = "CTRL",
      action = act.CloseCurrentPane({ confirm = true }),
    },
    {
      key = 't',
      mods = 'CTRL',
      action = act.SpawnTab 'CurrentPaneDomain',
    },
    -- activate resize mode
    {
      key = "r",
      mods = "LEADER",
      action = act.ActivateKeyTable({
        name = "resize_pane",
        one_shot = false,
      }),
    },

    -- toggle fullscreen (alt + enter also works)
    {
      key = 'F11',
      mods = '',
      action = wezterm.action.ToggleFullScreen,
    },

    -- focus panes
    {
      key = "k",
      mods = "LEADER",
      action = act.ActivatePaneDirection("Left"),
    },
    {
      key = "i",
      mods = "LEADER",
      action = act.ActivatePaneDirection("Right"),
    },
    {
      key = "e",
      mods = "LEADER",
      action = act.ActivatePaneDirection("Up"),
    },
    {
      key = "n",
      mods = "LEADER",
      action = act.ActivatePaneDirection("Down"),
    },

    -- add new panes
    {
      key = "v",
      mods = "LEADER",
      action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "h",
      mods = "LEADER",
      action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
  },

  key_tables = {
    resize_pane = {
      { key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 5 }) },
      { key = "k", action = act.AdjustPaneSize({ "Left", 5 }) },

      { key = "RightArrow", action = act.AdjustPaneSize({ "Right", 5 }) },
      { key = "i", action = act.AdjustPaneSize({ "Right", 5 }) },

      { key = "UpArrow", action = act.AdjustPaneSize({ "Up", 2 }) },
      { key = "e", action = act.AdjustPaneSize({ "Up", 2 }) },

      { key = "DownArrow", action = act.AdjustPaneSize({ "Down", 2 }) },
      { key = "n", action = act.AdjustPaneSize({ "Down", 2 }) },

      { key = "Escape", action = "PopKeyTable" },
    },
  },
}
