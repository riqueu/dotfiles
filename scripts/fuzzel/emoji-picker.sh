#!/usr/bin/env bash

fuzzel_command="fuzzel --dmenu"

# get selected emoji via fuzzel from emoji file
chosen=$(cat "$HOME/scripts/emoji" | ${fuzzel_command} | awk '{print $1}')

# no emoji chosen, exit the script
[ -z "$chosen" ] && exit

# if you run this command with an argument, it will automatically insert the
# character. otherwise, show a message that the emoji has been copied.
if [ -n "$1" ]; then
    ydotool type "$chosen"
else
    printf "%s" "$chosen" | wl-copy
    # notify-send -t 2000 "Emoji Copied" "'$chosen' copied to clipboard."
fi
