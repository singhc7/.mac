# ==========================================
# Environment Variables & Exports
# ==========================================

# --- Editor ---
export EDITOR='nvim'
export VISUAL='nvim'

# --- Path Modifications ---
# User local bin
export PATH="$HOME/.local/bin:$PATH"
# NPM global packages
export PATH="$HOME/.npm-global/bin:$PATH"

# --- NNN Configuration ---
# Plugins:
# o: fzopen (fuzzy search)
# n: nuke (smart opener)
# r: rclone (loads rclone to mount cloud drives)
# z: zoxide (uses autojump feature from zoxide)
# m: nmount to mount physical drives
# t: t will be safe trash
export NNN_PLUG='o:fzopen;n:nuke;r:rclone;m:nmount;z:autojump;t:trash'

# General Settings
export NNN_OPTS="adeH"          # detail mode, use EDITOR, show hidden
export NNN_ICONS=1
export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
