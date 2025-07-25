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

# URL-encode the query string
urlencode() {
    echo -n "$1" | xxd -plain | sed 's/../& /g' | awk '{for (i=1; i<=NF; i++) printf "%%%s", toupper($i)}'
}

main() {
  # pass the list to tofi
  platform=$( (gen_list) | tofi )

  if [[ -z "$platform" ]]; then
    exit
  fi

  # get search query
  # query=$( (echo "") | ${tofi_command} --prompt-text="$platform > " )
  query=$( (echo "") | ${tofi_command} )
  
  if [[ -z "$query" ]]; then
    exit
  fi

  encoded_query=$(urlencode "$query")
  url=""

  case "$platform" in
    "Backloggd")
      # saerch url for fallback on backloggd
      search_url="${URLS[$platform]}${encoded_query}"
      
      # find the first game name link (via grep and sed)
      relative_path=$(curl -s "$search_url" | grep -A 2 'game-name' | grep -o -m 1 'href="[^"]*"' | sed 's/href="\([^"]*\)"/\1/')
      
      if [[ -n "$relative_path" ]]; then
        # if path found, construct the full URL
        url="https://backloggd.com${relative_path}"
      else
        # otherwise, fall back to the search page
        url="$search_url"
      fi
      ;;

    "Letterboxd")
      # search and AJAX URLs
      search_url="${URLS[$platform]}${encoded_query}"
      ajax_url="https://letterboxd.com/s/search/${encoded_query}/"
      
      # using grep and sed to find the data-film-slug attribute
      relative_path=$(curl -s "$ajax_url" | grep -o -m 1 'data-film-slug="[^"]*"' | sed -e 's/data-film-slug="\([^"]*\)".*/\1/')
      
      if [[ -n "$relative_path" ]]; then
        # if found relative path, construct the full URL
        url="https://letterboxd.com/film/${relative_path}"
      else
        # otherwise, fall back to the search page
        url="$search_url"
      fi
      ;;
      
    "Spotify")
      # spotify uses a different scheme
      url="${URLS[$platform]}${encoded_query}"
      ;;

    *)
      # all other platforms use the standard URL format
      url="${URLS[$platform]}${encoded_query}"
      ;;
  esac
  
  # Open the final URL
   xdg-open "$url"
}

main

exit 0