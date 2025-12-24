alias ff "fastfetch --config examples/27.jsonc"
alias fetch "fastfetch --config examples/30.jsonc"
alias q exit
alias :q exit
alias icat "kitten icat"
alias cl clear
alias vi nvim
alias op "handlr open"
alias lanip "ip route get 1.1.1.1 | sed -n 's/.* src \([0-9.]*\).*/\1/p'"

alias ytdl "yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio'"

alias mirr "wl-mirror eDP-1 & disown"

alias susp "systemctl suspend"

alias orch 'pacman -Qdtq | xargs -r pacman -Qi | \
awk '\''/^Name/ { printf "%s ", $3 }
/^Version/ { printf "%s\n", $3 }
/^Description/ { print "    " substr($0, index($0,$2)) "\n" }'\'


alias sp "sudo pacman"
alias sps "sudo pacman -S"
alias spu "sudo pacman -Syu"
alias pas "paru -S"
