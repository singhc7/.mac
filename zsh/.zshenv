# Set ZDOTDIR so zsh reads configs from ~/.config/zsh instead of ~
export ZDOTDIR="$HOME/.config/zsh"

# Load Rust (if installed)
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi
