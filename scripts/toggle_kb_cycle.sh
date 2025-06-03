#!/usr/bin/env bash

LOCK_FILE="/tmp/cycle_kb.lock"
CYCLE_SCRIPT="$HOME/scripts/cycle_kb.sh"

if [ -e "$LOCK_FILE" ]; then
    # Lock file exists. Read the PID from the file and kill that process.
    kill "$(cat "$LOCK_FILE")"
else
    # Lock file does not exist. Start the cycle script in the background.
    "$CYCLE_SCRIPT" &
fi