#!/usr/bin/env bash

# check if niri or Hyprland
case "$XDG_CURRENT_DESKTOP" in
    "Hyprland")
        launcher="tofi"
        launcher_command="$launcher --require-match=false"
        ;;
    "niri" | *)
        launcher="fuzzel"
        launcher_command="$launcher --dmenu --lines=13"
        ;;
esac

declare -A URLS

URLS=(
    ["DuckDuckGo"]="https://duckduckgo.com/?q="
    ["Google"]="https://www.google.com/search?q="
    ["YouTube"]="https://www.youtube.com/results?search_query="
    ["Maps"]="https://www.google.com/maps/search/"
    ["Images"]="https://www.google.com/search?tbm=isch&q="
    ["Github"]="https://github.com/search?q="
    ["Arch Wiki"]="https://wiki.archlinux.org/title/"
    ["Wikipedia"]="https://en.wikipedia.org/wiki/Special:Search?search="
    ["Spotify"]="spotify:search:"
    ["RateYourMusic"]="https://rateyourmusic.com/search?searchterm="
    ["Backloggd"]="https://backloggd.com/search/games/"
    ["Letterboxd"]="https://letterboxd.com/search/"
)

# display order
ORDER=("DuckDuckGo" "Google" "Maps" "Images" "RateYourMusic" "Wikipedia" "Spotify" "YouTube" "Backloggd" "Letterboxd" "Github" "Arch Wiki")

# list for the launcher
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
    # pass the list to the launcher
    platform=$( (gen_list) | $launcher_command )

    if [[ -z "$platform" ]]; then
      exit
    fi

    # get search query using the launcher with a dynamic prompt
    query=$(echo "" | $launcher_command --prompt="$platform > ")
    
    if [[ -z "$query" ]]; then
      exit
    fi

    encoded_query=$(urlencode "$query")
    url=""

    case "$platform" in
      "Backloggd")
        search_url="https://backloggd.com/search/results.turbo_stream?query=${encoded_query}&type=games"
        relative_path=$(curl -s "$search_url" | grep -A 2 'game-name' | grep -o -m 1 'href="[^"]*"' | sed 's/href="\([^"]*\)"/\1/')
        
        if [[ -n "$relative_path" ]]; then
          url="https://backloggd.com${relative_path}"
        else
          url="${URLS[$platform]}${encoded_query}"
        fi
        ;;

      "Letterboxd")
        search_url="${URLS[$platform]}${encoded_query}"
        ajax_url="https://letterboxd.com/s/search/${encoded_query}/"
        relative_path=$(curl -s "$ajax_url" | grep -o -m 1 'data-film-slug="[^"]*"' | sed -e 's/data-film-slug="\([^"]*\)".*/\1/')
        
        if [[ -n "$relative_path" ]]; then
          url="https://letterboxd.com/film/${relative_path}"
        else
          url="$search_url"
        fi
        ;;
        
      "Spotify")
        url="${URLS[$platform]}${encoded_query}"
        ;;

      *)
        url="${URLS[$platform]}${encoded_query}"
        ;;
    esac
    
    xdg-open "$url"
}

main

exit 0
