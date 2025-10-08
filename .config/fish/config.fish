if status is-interactive
    # Commands to run in interactive sessions can go here
end

source ~/.config/fish/conf.d/aliases.fish
source ~/.config/fish/conf.d/other.fish

set -gx PYENV_ROOT "$HOME/.pyenv"
status is-interactive; and pyenv init - | source
