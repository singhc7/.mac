# ==========================================
# Aliases
# ==========================================

# --- Eza (Modern replacement for ls) ---
if command -v eza >/dev/null 2>&1; then
    alias ls='eza --icons --group-directories-first'
    alias ll='eza -lh --icons --git --group-directories-first'
    alias la='eza -lha --icons --git --group-directories-first'
    alias lt='eza --tree --icons --group-directories-first'
    alias l.='eza -d .* --icons --group-directories-first'
fi

# --- Platform Specific ---
if [[ "$OSTYPE" == linux* ]]; then
    # To update all the packages (Fedora/DNF example from current config)
    alias update-all='sudo dnf upgrade && flatpak update && snap refresh && pipx upgrade-all'
    # To clean and remove old dependencies
    alias clean-system='sudo dnf autoremove && flatpak uninstall --unused && pipx interpreter prune'
fi

if [[ "$OSTYPE" == darwin* ]]; then
    # macOS specific aliases (if any)
    :
fi
