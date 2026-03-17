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
    # Update system, flatpaks, snaps, and package manager specific apps/packages
    alias update-all='sudo dnf upgrade && \
                      flatpak update && \
                      snap refresh && \
                      { command -v pipx >/dev/null && pipx upgrade-all || true } && \
                      { command -v rustup >/dev/null && rustup update || true } && \
                      { command -v cargo-install-update >/dev/null && cargo install-update -a || true } && \
                      { command -v npm >/dev/null && npm update -g || true }'

    # Clean up system caches, unused packages, and package manager artifacts
    alias clean-system='sudo dnf autoremove && \
                        flatpak uninstall --unused && \
                        { command -v pipx >/dev/null && pipx interpreter prune || true } && \
                        { command -v pip >/dev/null && pip cache purge || true } && \
                        { command -v npm >/dev/null && npm cache clean --force || true } && \
                        { command -v cargo >/dev/null && { command -v cargo-cache >/dev/null && cargo cache -a || true }; true }'
fi

if [[ "$OSTYPE" == darwin* ]]; then
    # macOS specific aliases (if any)
    :
fi
