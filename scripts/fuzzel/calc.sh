#!/usr/bin/env bash
set -x # Debugging flag, remove after fixing

# Use fuzzel's dmenu mode with a custom prompt.
# We explicitly redirect /dev/null to standard input to ensure
# fuzzel waits for user input and doesn't get confused by an empty pipe.
FUZZEL_PROMPT="calc> "

# Get the operation from the user.
# The user's typed text is captured when they press Enter.
operation=$(fuzzel --dmenu --prompt "$FUZZEL_PROMPT" < /dev/null)

# Exit if no operation was entered (e.g., user pressed Escape).
[ -z "$operation" ] && exit

# Perform the calculation using `bc -l` for floating-point arithmetic.
# We also use `sed` to remove any backslash characters that might interfere.
# Error handling: if `bc` returns an empty string or an error, `result` will be empty.
result=$(echo "$operation" | sed 's/\\//g' | bc -l 2>/dev/null)

# Check if the result is valid.
if [ -z "$result" ]; then
    notify-send "Invalid operation." "Please provide a valid mathematical expression."
    exit
fi

# Copy the valid result to the clipboard.
echo "$result" | wl-copy

# You can add a notification to confirm the result has been copied.
notify-send -t 2000 "Result Copied" "Result: $result"
