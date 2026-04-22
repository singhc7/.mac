# ==========================================
# External Tool Integrations
# ==========================================

# --- fzf ---
[[ -f ~/.config/fzf/fzf.zsh ]] && source ~/.config/fzf/fzf.zsh

# --- Deno ---
if [ -f "$HOME/.deno/env" ]; then
    . "$HOME/.deno/env"
fi

# --- zoxide ---
# Initialize zoxide (defines z and zi)
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
    # Also alias cd to z to allow both commands to work
    alias cd="z"
    # Optimization: Limit the frequency of database cleanup
    export _ZO_MAXAGE=10000
fi

# --- Starship Prompt ---
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

# --- ssh-agent ---
# Add passkey to the ssh-agent on each shell instance
ssh-add --apple-load-keychain 2>/dev/null
