# ==========================================
# Zoxide Configuration (Fast Directory Jumper)
# ==========================================

# Initialize zoxide for zsh.
# --cmd cd: Replace the builtin `cd` with `zoxide`
# This allows you to use `cd path/to/dir` normally, but also `cd pattern` to jump.
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh --cmd cd)"
    # Explicitly alias cd to z to ensure it works with patterns
    alias cd="z"
fi

# Optimization: Limit the frequency of database cleanup to improve shell startup time
# Default is 10,000, which is usually fine.
export _ZO_MAXAGE=10000
