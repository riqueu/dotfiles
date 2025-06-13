alias ff fastfetch
alias fetch "fastfetch --config examples/17.jsonc"
alias q exit
alias :q exit
alias icat "kitten icat"
alias cl clear
alias vi nvim

alias mirror "wl-mirror eDP-1 & disown"
alias phonewifi "scrcpy -e --no-audio"
alias phone "scrcpy -d --no-audio"

alias frontcamwifi "scrcpy --video-source=camera --video-codec=h265 --camera-size=1920x1080 --camera-facing=front --no-audio -e"
alias frontcam "scrcpy --video-source=camera --video-codec=h265 --camera-size=1920x1080 --camera-facing=front --no-audio -d"

alias backcamwifi "scrcpy --video-source=camera --video-codec=h265 --camera-size=1920x1080 --camera-facing=back --no-audio -e"
alias backcam "scrcpy --video-source=camera --video-codec=h265 --camera-size=1920x1080 --camera-facing=back --no-audio -d"

alias susp "systemctl suspend"

alias sp "sudo pacman"
alias sps "sudo pacman -S"
alias spu "sudo pacman -Syu"
alias ys "yay -S"
