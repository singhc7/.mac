# ==========================================
# Shell Options
# ==========================================

# Ensure the associative array exists before we try to populate it
typeset -gA ZSH_HIGHLIGHT_STYLES

# --- Syntax Highlighting Styles ---
# Bold for commands and programs
ZSH_HIGHLIGHT_STYLES[command]='bold'
ZSH_HIGHLIGHT_STYLES[alias]='bold'
ZSH_HIGHLIGHT_STYLES[builtin]='bold'
ZSH_HIGHLIGHT_STYLES[function]='bold'
ZSH_HIGHLIGHT_STYLES[precommand]='bold'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='none'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='none'

# Other styling
ZSH_HIGHLIGHT_STYLES[path]='underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='underline'
ZSH_HIGHLIGHT_STYLES[globbing]='none'

# --- Output Reset ---
# Load terminfo module to ensure $terminfo is available
zmodload zsh/terminfo
preexec() {
    # Reset all text attributes (bold, italics, etc.) before command output
    print -rn $terminfo[sgr0]
}

# --- History ---
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_space

# --- General ---
setopt autocd           # If a command is a directory, cd into it
# setopt interactivecomments
# setopt magicequalsubst  # Completion for path-like arguments
# setopt notify           # Notify of background job completion immediately
# setopt prompt_subst     # Allow parameter expansion in prompt
