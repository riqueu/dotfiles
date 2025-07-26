#!/usr/bin/env bash

# launcher based on de
case "$XDG_CURRENT_DESKTOP" in
    "Hyprland")
        launcher_command="tofi --width=25%"
        ;;
    "niri" | *)
        launcher_command="fuzzel --dmenu"
        ;;
esac

# get user selection via launcher from emoji file
chosen=$(cat "$HOME/scripts/emoji" | ${launcher_command} | awk '{print $1}')

# exit if no emoji was chosen
[ -z "$chosen" ] && exit

# if you run this command with an argument, it will automatically insert the
# character. otherwise, show a message that the emoji has been copied.
if [ -n "$1" ]; then
    ydotool type "$chosen"
else
    printf "%s" "$chosen" | wl-copy
    # notify-send -t 2000 "Emoji Copied" "'$chosen' copied to clipboard."
fi
