#!/bin/bash

# get user selection via tofi from emoji file.
chosen=$(cat $HOME/scripts/emoji | tofi | awk '{print $1}')

# exit if none chosen.
[ -z "$chosen" ] && exit

# if you run this command with an argument, it will automatically insert the
# character. otherwise, show a message that the emoji has been copied.
if [ -n "$1" ]; then
	ydotool type "$chosen"
else
  printf "$chosen" | wl-copy
	# notify-send "'$chosen' copied to clipboard." &
fi

