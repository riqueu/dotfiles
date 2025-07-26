#!/usr/bin/env bash
set -euo pipefail

mapfile=$(mktemp)
selfile=$(mktemp)

fuzzel_command="fuzzel --dmenu"

# Build "relative::full" map
find "$1" \( -type f -o -type d \) \
  -printf '/%P::%p\n' > "$mapfile"

# Show only the relative paths fuzzel-style
cut -d ':' -f1 "$mapfile" | \
  ${fuzzel_command} > "$selfile"

selected=$(<"$selfile")
[[ -z $selected ]] && { rm -f "$mapfile" "$selfile"; exit 1; }

# Lookup full path
full_path=$(grep -m1 -F "${selected}::" "$mapfile" | cut -d ':' -f3-)

rm -f "$mapfile" "$selfile"
thunar "$full_path" &
#kitty "$full_path" &
