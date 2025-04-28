#!/bin/bash

declare -A URLS

URLS=(
  ["Google"]="https://www.google.com/search?q="
  ["YouTube"]="https://www.youtube.com/results?search_query="
  ["Github"]="https://github.com/search?q="
  ["Arch Wiki"]="https://wiki.archlinux.org/title/"
)

# display order
ORDER=("Google" "YouTube" "Github" "Arch Wiki")

# list for tofi
gen_list() {
    for i in "${ORDER[@]}"
    do
      echo "$i"
    done
}

main() {
  # pass the list to tofi
  platform=$( (gen_list) | tofi )

  if [[ -n "$platform" ]]; then
    #query=$( (echo "") | tofi --prompt-text "$platform > " --require-match=false )
    query=$( (echo "") | tofi --require-match=false )
    
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
