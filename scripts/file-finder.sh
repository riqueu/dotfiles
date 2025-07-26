#!/usr/bin/env bash
set -euo pipefail

# get desktop environment
case "$XDG_CURRENT_DESKTOP" in
    "Hyprland")
        # tofi command with desired sizing
        launcher_command="tofi --font-size=12 --width=50% --height=50%"
        ;;
    "niri" | *)
        launcher_command="fuzzel --dmenu"
        ;;
esac

mapfile=$(mktemp)
selfile=$(mktemp)

# Build "relative::full" map
# The "$1" refers to the first argument passed to the script (e.g., "~/Documents")
find "$1" \( -type f -o -type d \) \
  -printf '/%P::%p\n' > "$mapfile"

# Show only the relative paths using the selected launcher
cut -d ':' -f1 "$mapfile" | \
  ${launcher_command} > "$selfile"

selected=$(<"$selfile")
[[ -z $selected ]] && { rm -f "$mapfile" "$selfile"; exit 1; }

# Lookup full path
full_path=$(grep -m1 -F "${selected}::" "$mapfile" | cut -d ':' -f3-)

# Clean up temporary files
rm -f "$mapfile" "$selfile"

thunar "$full_path" &
# kitty "$full_path" &
