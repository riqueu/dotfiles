source /usr/share/cachyos-fish-config/cachyos-config.fish

source ~/.config/fish/conf.d/aliases.fish
source ~/.config/fish/conf.d/other.fish

set -gx PYENV_ROOT "$HOME/.pyenv"
status is-interactive; and pyenv init - | source

# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
    # smth smth
end
