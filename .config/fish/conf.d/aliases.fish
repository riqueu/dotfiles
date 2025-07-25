alias ff fastfetch
alias fetch "fastfetch --config examples/17.jsonc"
alias q exit
alias :q exit
alias icat "kitten icat"
alias cl clear
alias vi nvim

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
