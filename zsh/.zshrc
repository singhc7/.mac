# 1. Powerlevel10k Instant Prompt (Must be at the very top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${USER}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${USER}.zsh"
fi
# ==========================================
# Antidote Bootstrap & Load
# ==========================================
# If Antidote isn't installed, clone it automatically
if [[ ! -d ~/.antidote ]]; then
    echo "Installing Antidote..."
    git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote
fi
# 2. Load Antidote (Your Plugin Manager)
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
# 3. Load your plugins (Includes Powerlevel10k, Autosuggestions, etc.)
antidote load
# 4. Load Powerlevel10k Visual Settings
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# 5. Load fzf configuration
[[ -f ~/.config/fzf/fzf.zsh ]] && source ~/.config/fzf/fzf.zsh

# 6. Load Deno (if installed)
if [ -f "$HOME/.deno/env" ]; then
    . "$HOME/.deno/env"
fi
export PATH="$HOME/.local/bin:$PATH"
# ==========================================
# Platform Specific Configuration
# ==========================================
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    [[ -f ~/.zshrc.linux ]] && source ~/.zshrc.linux
elif [[ "$OSTYPE" == "darwin"* ]]; then
    [[ -f ~/.zshrc.macos ]] && source ~/.zshrc.macos
fi

export EDITOR='nvim'
export VISUAL='nvim'
# --- Installs npm packages globally into user space ---
export PATH=~/.npm-global/bin:$PATH

# --- Eza Aliases (Modern replacement for ls) ---
if command -v eza >/dev/null 2>&1; then
    alias ls='eza --icons --group-directories-first'
    alias ll='eza -lh --icons --git --group-directories-first'
    alias la='eza -lha --icons --git --group-directories-first'
    alias lt='eza --tree --icons --group-directories-first'
    alias l.='eza -d .* --icons --group-directories-first'
fi
