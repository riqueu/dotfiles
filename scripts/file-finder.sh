#!/usr/bin/env bash
set -euo pipefail

# get desktop environment (i use tofi with hyprland and fuzzel with niri)
case "$XDG_CURRENT_DESKTOP" in
    "Hyprland")
        launcher_command="tofi --font-size=12 --width=50% --height=50%"
        ;;
    "niri" | *)
        launcher_command="fuzzel --dmenu"
        ;;
esac

# list of relative paths and pipe it directly to the launcher
selected_path=$(find "$1" \( -type f -o -type d \) \
  -printf '%P\n' | ${launcher_command})

# exit if no file selected
[[ -z $selected_path ]] && exit 1

# get absolute path of the selected file/directory
full_path=$(realpath "$1/$selected_path")

# open the selected file/directory with the default application or file manager
thunar "$full_path" &
# kitty "$full_path" &
