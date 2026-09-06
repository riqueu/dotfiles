#!/bin/bash

MUSIC_DIR="/mnt/windir/srv/music/"

transcode_flac() {
    local file="$1"
    local outfile="${file%.flac}.opus"
    
    echo "Processing: $file"
    opusenc --bitrate 192 --quiet "$file" "$outfile"
    
    local enc_status=$?
    
    # 130 is the standard exit code for SIGINT (Ctrl+C)
    if [ $enc_status -eq 130 ]; then
        echo -e "\nInterrupt caught in worker. Cleaning up: $file"
        rm -f "$outfile"
        # MAGIC NUMBER: 255 tells xargs to instantly abort the entire queue
        exit 255 
    fi
    
    if [ $enc_status -eq 0 ] && [ -s "$outfile" ]; then
        rm "$file"
    else
        echo "ERROR: Failed or empty -> $file"
        rm -f "$outfile"
    fi
}
export -f transcode_flac

echo "Starting multi-core transcode..."
echo "Press Ctrl+C at any time to safely abort."

# We removed the global trap so xargs and the foreground group handle SIGINT naturally
find "$MUSIC_DIR" -type f -name "*.flac" -print0 | xargs -0 -n 1 -P $(nproc) bash -c 'transcode_flac "$@"' _

echo "Multi-core processing finished or aborted."
