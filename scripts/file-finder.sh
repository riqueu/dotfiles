#!/usr/bin/env bash
set -euo pipefail

# launcher command
launcher_command="fuzzel --dmenu"

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
