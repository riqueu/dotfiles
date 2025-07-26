#!/usr/bin/env bash
set -euo pipefail

# Select the launcher and its command based on the current desktop environment.
case "$XDG_CURRENT_DESKTOP" in
    "Hyprland")
        # tofi command with history-friendly flags
        launcher_command="tofi --width=30% --height=50% --font-size=12 --require-match=false --prompt-text=calc>"
        ;;
    "niri" | *)
        launcher_command="fuzzel --dmenu --prompt=calc>"
        ;;
esac

# Calculator history variables
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
tmp_dir="$XDG_CACHE_HOME/calc-history"
tmp_path="$tmp_dir/history"
is_history_value=false
max_age_days=10

mkdir -p "$tmp_dir"
if [ ! -f "$tmp_path" ]; then
    touch "$tmp_path"
fi

# Clean up old entries
find "$tmp_dir" -type f -mtime +$max_age_days -delete

# Get input operation, piping history to the launcher.
# The user can either select a history item or type a new one.
operation=$(cat "$tmp_path" | ${launcher_command})

# Exit if no operation provided (e.g., user pressed Escape)
if [ -z "$operation" ]; then
    exit
fi

# Remove operation when using history values
if [[ "$operation" == *"="* ]]; then
    operation=$(echo "$operation" | cut -d "=" -f 2)
    is_history_value=true
fi

# Calculate the result
# The `sed` part removes backslashes that can cause bc to error.
# `bc -l` enables floating-point math.
result=$(echo "$operation" | sed 's/\\//g' | bc -l 2>/dev/null)

# Exit if invalid operation
if [ -z "$result" ]; then
    notify-send "Invalid operation." "Please provide a valid mathematical expression."
    exit
fi

# Save the operation and result to history if it's a new calculation
if [ "$is_history_value" = false ]; then
    if ! grep -q "$operation = $result" "$tmp_path"; then
        temp_file=$(mktemp)
        echo "$operation = $result" > "$temp_file"
        cat "$tmp_path" >> "$temp_file"
        mv "$temp_file" "$tmp_path"
    fi
fi

# Copy result to clipboard
echo "$result" | wl-copy

# Notify the user of the result
#notify-send -t 2000 "Result: $result" "The result has been copied to the clipboard."
