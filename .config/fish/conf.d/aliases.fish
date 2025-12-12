alias ff fastfetch
alias fetch "fastfetch --config none"
alias q exit
alias :q exit
alias icat "kitten icat"
alias cl clear
alias vi nvim
alias op "handlr open"

alias ytdl "yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio'"

alias mirror "wl-mirror eDP-1 & disown"

alias susp "systemctl suspend"

alias orch 'pacman -Qdtq | xargs -r pacman -Qi | \
awk '\''/^Name/ { printf "%s ", $3 }
/^Version/ { printf "%s\n", $3 }
/^Description/ { print "    " substr($0, index($0,$2)) "\n" }'\'


alias sp "sudo pacman"
alias sps "sudo pacman -S"
alias spu "sudo pacman -Syu"
alias ys "yay -S"
