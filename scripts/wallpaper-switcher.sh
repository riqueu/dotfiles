#!/bin/bash

# WALLPAPERS PATH
DIR="$HOME/Pictures/wallpapers"

# Transition config (type swww img --help for more settings)
FPS=144
TYPE=any # center / left / etc
DURATION=0.50
STEP=255 # 1-255

SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-step $STEP"

# wofi window config (in %)
WIDTH=20
HEIGHT=30

# WOFI STYLES
CONFIG="$HOME/.config/wofi/config"
STYLE="$HOME/.config/wofi/style.css"
COLORS="$HOME/.config/wofi/colors"

# Kill swaybg if running
if [[ $(pidof swaybg) ]]; then
  pkill swaybg
fi

# Cache file for storing current wallpaper
CACHE_WALLPAPER="$HOME/.cache/current_wallpaper"
CURRENT_WALLPAPER=$(cat "$CACHE_WALLPAPER" 2>/dev/null || echo "")

# Get list of wallpapers
PICS=($(ls "$DIR" | grep -E "\.jpg$|\.jpeg$|\.png$|\.gif$"))

# Filter out current wallpaper from random selection
FILTERED_PICS=()
for pic in "${PICS[@]}"; do
  [[ "$DIR/$pic" != "$CURRENT_WALLPAPER" ]] && FILTERED_PICS+=("$pic")
done

# Check for command line argument
if [[ $# -ge 1 ]]; then
    case "$1" in
        rand)
            # Ensure swww daemon is running
            swww query || swww-daemon

            if [ ${#FILTERED_PICS[@]} -gt 0 ]; then
                selected_pic="${DIR}/${FILTERED_PICS[$RANDOM % ${#FILTERED_PICS[@]}]}"
                swww img "$selected_pic" $SWWW_PARAMS
                echo "$selected_pic" > "$CACHE_WALLPAPER"
                exit 0
            else
                echo "No other wallpapers available" >&2
                exit 1
            fi
            ;;
        *)
            echo "Unknown argument: $1" >&2
            exit 1
            ;;
    esac
fi

# Select random pic (if any are available)
if [ ${#FILTERED_PICS[@]} -gt 0 ]; then
  RANDOM_PIC=${FILTERED_PICS[$RANDOM % ${#FILTERED_PICS[@]}]}
  RANDOM_PIC_NAME="0. random"
else
  RANDOM_PIC=""
  RANDOM_PIC_NAME="0. No other wallpapers"
fi

# Start swww daemon if needed
swww query || swww-daemon

# Generate the menu list for wofi
menu() {
  printf "$RANDOM_PIC_NAME\n"
  for i in "${!PICS[@]}"; do
    idx=$((i + 1)) # start from 1
    if [[ "${PICS[$i]}" =~ \.gif$ ]]; then
      printf "$idx. ${PICS[$i]}\n"
    else
      printf "$idx. $(echo "${PICS[$i]}" | cut -d. -f1)\n"
    fi
  done
}

# Wofi Command
wofi_command="wofi --show dmenu \
  --prompt choose... \
  --conf $CONFIG --style $STYLE --color $COLORS \
  --width=$WIDTH% --height=$HEIGHT% \
  --cache-file=/dev/null \
  --hide-scroll --no-actions \
  --matching=fuzzy \
  --columns=2"

main() {
  choice=$(menu | ${wofi_command})

  # no choice case
  if [[ -z $choice ]]; then return; fi

  # random choice case
  if [[ "$choice" == "$RANDOM_PIC_NAME" ]]; then
    if [[ -n "$RANDOM_PIC" ]]; then
      swww img "${DIR}/${RANDOM_PIC}" $SWWW_PARAMS
      echo "${DIR}/${RANDOM_PIC}" > "$CACHE_WALLPAPER"
    fi
    return
  fi

  # specific wallpaper choice (subtract 1 because we started at index 1)
  pic_index=$(( $(echo "$choice" | cut -d. -f1) - 1 ))
  selected_pic="${DIR}/${PICS[$pic_index]}"
  swww img "$selected_pic" $SWWW_PARAMS
  echo "$selected_pic" > "$CACHE_WALLPAPER"
}

# Prevent multiple wofi instances
if pidof wofi >/dev/null; then
  killall wofi
  exit 0
else
  main
fi
