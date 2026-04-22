# ==========================================
# Aliases
# ==========================================

# --- nvim ---
if command -v nvim >/dev/null 2>&1; then
    alias vim=nvim
fi

# --- Updates (Homebrew) ---
if command -v brew >/dev/null 2>&1; then
    alias upsystem='brew update && brew upgrade'
fi

# --- Eza (Modern replacement for ls) ---
if command -v eza >/dev/null 2>&1; then
    alias ls='eza --icons --group-directories-first'
    alias ll='eza -lh --icons --git --group-directories-first'
    alias la='eza -lha --icons --git --group-directories-first'
    alias lt='eza --tree --level=2 --icons --group-directories-first'
    alias lt3='eza --tree --level=3 --icons --group-directories-first'
    alias l.='eza -d .* --icons --group-directories-first'
    alias lss='eza -lh --icons --git --group-directories-first --sort=size'
    alias lsm='eza -lh --icons --git --group-directories-first --sort=modified'
fi

# --- Rclone Power Tools ---
if command -v rclone >/dev/null 2>&1; then
    # Optimized mount (high-performance VFS caching)
    alias rcmount='rclone mount --vfs-cache-mode full \
                           --vfs-cache-max-age 24h \
                           --vfs-cache-max-size 10G \
                           --vfs-read-chunk-size 128M \
                           --vfs-read-chunk-size-limit 1G \
                           --daemon'

    # Fast and safe mirror sync
    alias rcsync='rclone sync -P --track-renames --fix-case'

    # Interactive remote file explorer
    alias rcls='rclone lsjson --human-readable --stat'
fi

# --- Navigation ---
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# --- Quick Info ---
alias path='echo $PATH | tr ":" "\n"'
alias ports='lsof -iTCP -sTCP:LISTEN -n -P'
alias ip='curl -s ifconfig.me'
alias weather='curl -s wttr.in'
