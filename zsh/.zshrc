# ==========================================
# Antidote Bootstrap & Load
# ==========================================
# If Antidote isn't installed, clone it automatically
if [[ ! -d ~/.antidote ]]; then
    echo "Installing Antidote..."
    git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote
fi

# Load Antidote (Your Plugin Manager)
source ${ZDOTDIR:-~}/.antidote/antidote.zsh

# Load your plugins (Autosuggestions, Completions, etc.)
antidote load

# ==========================================
# Modular Configurations
# ==========================================
# Use ~/.zsh if it exists (standard Stow behavior)
ZSH_CONFIG_DIR="$HOME/.zsh"

# If ~/.zsh doesn't exist, fall back to the relative path of this script
if [[ ! -d "$ZSH_CONFIG_DIR" ]]; then
    ZSH_CONFIG_DIR="${${(%):-%x}:h}/.zsh"
fi

# 1. Exports first (sets up PATH for tools)
[[ -f "$ZSH_CONFIG_DIR/exports.zsh" ]] && source "$ZSH_CONFIG_DIR/exports.zsh"

# 2. Options next (sets up shell options and keybindings like vi-mode)
[[ -f "$ZSH_CONFIG_DIR/options.zsh" ]] && source "$ZSH_CONFIG_DIR/options.zsh"

# 3. Integrations next (initializes tools using PATH)
[[ -f "$ZSH_CONFIG_DIR/integrations.zsh" ]] && source "$ZSH_CONFIG_DIR/integrations.zsh"

# 4. Everything else
for config in functions aliases; do
    if [[ -f "$ZSH_CONFIG_DIR/$config.zsh" ]]; then
        source "$ZSH_CONFIG_DIR/$config.zsh"
    fi
done
