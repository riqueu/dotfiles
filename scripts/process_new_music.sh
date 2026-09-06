#!/bin/bash

# Removed trailing slashes here so we can control them explicitly later
STAGING_DIR="/mnt/windir/srv/music_staging"
MUSIC_DIR="/mnt/windir/srv/music"

# 1. Define the transcode logic for individual files
transcode_flac() {
    local file="$1"
    local outfile="${file%.flac}.opus"
    
    echo "Processing: $file"
    
    # Strip any hidden volume tags from the FLAC before encoding
    metaflac --remove-replay-gain "$file" 2>/dev/null
    
    # Encode the clean file
    opusenc --bitrate 192 --quiet "$file" "$outfile"
    
    local enc_status=$?
    
    # Catch Ctrl+C and hard-abort the queue
    if [ $enc_status -eq 130 ]; then
        echo -e "\nInterrupt caught. Cleaning up: $file"
        rm -f "$outfile"
        exit 255 
    fi
    
    # Verify success AND that the file isn't empty
    if [ $enc_status -eq 0 ] && [ -s "$outfile" ]; then
        rm "$file"
    else
        echo "ERROR: Transcode failed for -> $file"
        echo "Keeping original FLAC file."
        rm -f "$outfile"
        exit 0 
    fi
}
export -f transcode_flac


echo "1. Uploading original files to Google Drive Archive..."
# BRAKE 1: If rclone fails (network drop, full drive, etc.), abort immediately.
rclone copy "${STAGING_DIR}/" gdrive_crypt: -P || {
    echo "ERROR: Cloud upload failed! Aborting to protect local lossless files."
    exit 1
}


echo "2. Transcoding staging FLACs to Opus..."
# BRAKE 2: If xargs hits a 255 (Ctrl+C) or encounters an error, abort immediately.
find "${STAGING_DIR}" -type f -iname "*.flac" -print0 | xargs -0 -n 1 -P $(nproc) bash -c 'transcode_flac "$@"' _ || {
    echo "ERROR: Transcode process was interrupted or failed! Aborting."
    exit 1
}


echo "3. Moving optimized files to Navidrome library..."
# THE FIX: 
# 1. --exclude keeps any leftover (failed) FLACs from polluting your Navidrome library.
# 2. --remove-source-files deletes files from the staging area ONLY if they successfully copied.
rsync -a --exclude='*.[fF][lL][aA][cC]' --remove-source-files "${STAGING_DIR}/" "${MUSIC_DIR}/" || {
    echo "ERROR: File migration to Navidrome failed! Aborting."
    exit 1
}

echo "4. Cleaning up staging area..."
# THE FIX: 
# Instead of a blind wipe, we tell find to ONLY delete directories that are completely empty.
# If a FLAC failed, it will remain in its folder. The folder is no longer empty, so find ignores it.
find "${STAGING_DIR}" -mindepth 1 -type d -empty -delete

echo "All done! Check Navidrome."
