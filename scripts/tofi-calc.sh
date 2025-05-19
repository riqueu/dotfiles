#!/usr/bin/env bash

# calculator history variables
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
tmp_dir="$XDG_CACHE_HOME/tofi-calc"
tmp_path="$tmp_dir/history"
is_history_value=false
max_age_days=10

# tofi commands
tofi_command="tofi --width=30% --height=50% --font-size=12 --require-match=false"

mkdir -p "$tmp_dir"
if [ ! -f "$tmp_path" ]; then
    touch "$tmp_path"
fi

# clean up old entries
find "$tmp_dir" -type f -mtime +$max_age_days -delete

# input operation
operation=$(cat $tmp_path | ${tofi_command})

# exit if no operation provided
if [ -z "$operation" ]; then
	# notify-send "No operation provided." "Please provide a valid operation."
	exit
fi

# Remove operation when using history values
if [[ "$operation" == *"="* ]]; then
	operation=$(echo "$operation" | cut -d "=" -f 2)
	is_history_value=true
fi

# calculate the result and delete new line or backslash characters
result=$(echo "$operation" | bc -l)

# exit if invalid operation
if [ -z "$result" ]; then
	# notify-send "Invalid operation." "Please provide a valid operation."
	exit
fi

# save the operation and result to history 
if [ "$is_history_value" = false ]; then
	if ! grep -q "$operation = $result" "$tmp_path"; then
	    temp_file=$(mktemp)
	    echo "$operation = $result" > "$temp_file"
	    cat "$tmp_path" >> "$temp_file"
	    mv "$temp_file" "$tmp_path"
	fi
fi

# copy result to clipboard
echo "$result" | wl-copy

# notify-send "Result: $result" "The result has been copied to the clipboard."
