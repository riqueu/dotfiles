#!/usr/bin/env bash

declare -A URLS

URLS=(
  ["Google"]="https://www.google.com/search?q="
  ["YouTube"]="https://www.youtube.com/results?search_query="
  ["Github"]="https://github.com/search?q="
  ["Arch Wiki"]="https://wiki.archlinux.org/title/"
  ["Wikipedia"]="https://en.wikipedia.org/wiki/Special:Search?search="
  ["Spotify"]="spotify:search:"
  ["RateYourMusic"]="https://rateyourmusic.com/search?searchterm="
  ["Backloggd"]="https://backloggd.com/search/games/"
  ["Letterboxd"]="https://letterboxd.com/search/"
)

# display order
ORDER=("Google" "RateYourMusic" "Wikipedia" "Spotify" "YouTube" "Backloggd" "Letterboxd" "Github" "Arch Wiki")

# tofi commands
tofi_command="tofi --require-match=false"

# list for tofi
gen_list() {
    for i in "${ORDER[@]}"
    do
      echo "$i"
    done
}

urlencode() {
    echo -n "$1" | xxd -plain | sed 's/../& /g' | awk '{for (i=1; i<=NF; i++) printf "%%%s", toupper($i)}'
}

main() {
  # pass the list to tofi
  platform=$( (gen_list) | tofi )

  if [[ -n "$platform" ]]; then
    #query=$( (echo "") | tofi --prompt-text "$platform > " --require-match=false )
    query=$( (echo "") | ${tofi_command} )
    
    # check if spotify to encode
    if [[ "$platform" == "Spotify" ]]; then
      query=$(urlencode "$query")
    fi

    if [[ -n "$query" ]]; then
      url=${URLS[$platform]}$query
      xdg-open "$url"
    else
      exit
    fi

  else
    exit
  fi
}

main

exit 0
