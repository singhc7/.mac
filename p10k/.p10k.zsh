# Powerlevel10k configuration.
# Mirrors the prior starship aesthetic: a flat, two-line prompt with
# nerd-font icons and Apple system colors as accents.
# Reload after edits with: p10k reload

'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh -o extended_glob

  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'

  # ===== Apple system colors (closest 256-color matches) =====
  local apple_blue=33      # System Blue   #007AFF
  local apple_purple=135   # System Purple #AF52DE
  local apple_red=203      # System Red    #FF3B30
  local apple_orange=208   # System Orange #FF9500
  local apple_yellow=220   # System Yellow #FFCC00
  local apple_green=41     # System Green  #34C759
  local apple_cyan=39      # System Cyan   #32ADE6
  local apple_white=15     # Label
  local apple_gray=245     # System Gray   #8E8E93

  # ===== Prompt segments =====
  # Left line 1: macOS icon, dir, git, language versions.
  # Left line 2: prompt character only.
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    os_icon
    dir
    vcs
    pyenv
    java_version
    newline
    prompt_char
  )

  # Right line 1: jobs, command duration. Sits next to line 1 like starship's $fill.
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    background_jobs
    command_execution_time
  )

  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
  typeset -g POWERLEVEL9K_RPROMPT_ON_NEWLINE=false

  # Flat aesthetic — no powerline backgrounds or separators.
  typeset -g POWERLEVEL9K_BACKGROUND=
  typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=
  typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=
  typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=' '
  typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=' '
  typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=
  typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL=
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL=
  typeset -g POWERLEVEL9K_EMPTY_LINE_LEFT_PROMPT_FIRST_SEGMENT_END_SYMBOL=

  # ===== os_icon =====
  typeset -g POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION=''
  typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND=$apple_white

  # ===== dir =====
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=$apple_blue
  typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=$apple_blue
  typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=$apple_blue
  typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last
  typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
  typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=80
  typeset -g POWERLEVEL9K_DIR_HYPERLINK=false
  typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=v3
  typeset -g POWERLEVEL9K_DIR_NOT_WRITABLE_VISUAL_IDENTIFIER_EXPANSION=' 󰌾'
  typeset -g POWERLEVEL9K_DIR_NOT_WRITABLE_LOCKED_VISUAL_IDENTIFIER_EXPANSION=' 󰌾'

  # ===== vcs (git) — branch + status icons matching the prior config =====
  function my_git_formatter() {
    emulate -L zsh
    if [[ -n $P9K_CONTENT ]]; then
      typeset -g my_git_format=$P9K_CONTENT
      return
    fi

    local branch_color=135  # apple_purple
    local status_color=203  # apple_red
    local res

    if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
      res+="%F{$branch_color}%B ${VCS_STATUS_LOCAL_BRANCH//\%/%%}%b%f"
    elif [[ -n $VCS_STATUS_TAG ]]; then
      res+="%F{$branch_color}%B# ${VCS_STATUS_TAG//\%/%%}%b%f"
    fi

    local stat=""
    (( VCS_STATUS_HAS_STAGED ))     && stat+=" "
    (( VCS_STATUS_HAS_UNSTAGED ))   && stat+=" "
    (( VCS_STATUS_HAS_UNTRACKED ))  && stat+=" "
    if (( VCS_STATUS_COMMITS_AHEAD && VCS_STATUS_COMMITS_BEHIND )); then
      stat+=" "
    elif (( VCS_STATUS_COMMITS_AHEAD )); then
      stat+=" ${VCS_STATUS_COMMITS_AHEAD}"
    elif (( VCS_STATUS_COMMITS_BEHIND )); then
      stat+=" ${VCS_STATUS_COMMITS_BEHIND}"
    fi

    [[ -n $stat ]] && res+=" %F{$status_color}%B${stat# }%b%f"

    typeset -g my_git_format=$res
  }
  functions -M my_git_formatter 2>/dev/null

  typeset -g POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true
  typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${$((my_git_formatter()))+${my_git_format}}'
  typeset -g POWERLEVEL9K_VCS_LOADING_CONTENT_EXPANSION=$POWERLEVEL9K_VCS_CONTENT_EXPANSION
  typeset -g POWERLEVEL9K_VCS_BACKENDS=(git)
  typeset -g POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-untracked git-aheadbehind)

  # ===== prompt_char (the ❯ on line 2) =====
  typeset -g POWERLEVEL9K_PROMPT_CHAR_BACKGROUND=
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VIINS_FOREGROUND=$apple_green
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VIINS_FOREGROUND=$apple_red
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VICMD_FOREGROUND=$apple_cyan
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VICMD_FOREGROUND=$apple_cyan
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VIVIS_FOREGROUND=$apple_cyan
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VIVIS_FOREGROUND=$apple_cyan
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VIOWR_FOREGROUND=$apple_cyan
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_VIOWR_FOREGROUND=$apple_cyan
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='V'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIOWR_CONTENT_EXPANSION='▶'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=

  # ===== command_execution_time =====
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=2
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=$apple_orange
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PREFIX='took '
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_VISUAL_IDENTIFIER_EXPANSION=

  # ===== background_jobs =====
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=$apple_cyan
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VISUAL_IDENTIFIER_EXPANSION='󰜎'
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=false

  # ===== pyenv (python) =====
  typeset -g POWERLEVEL9K_PYENV_FOREGROUND=$apple_yellow
  typeset -g POWERLEVEL9K_PYENV_VISUAL_IDENTIFIER_EXPANSION=''
  typeset -g POWERLEVEL9K_PYENV_PROMPT_ALWAYS_SHOW=false
  typeset -g POWERLEVEL9K_PYENV_SOURCES=(shell local global)
  typeset -g POWERLEVEL9K_PYENV_SHOW_SYSTEM=true

  # ===== java_version =====
  typeset -g POWERLEVEL9K_JAVA_VERSION_FOREGROUND=$apple_red
  typeset -g POWERLEVEL9K_JAVA_VERSION_VISUAL_IDENTIFIER_EXPANSION=''
  typeset -g POWERLEVEL9K_JAVA_VERSION_FULL=false
  typeset -g POWERLEVEL9K_JAVA_VERSION_PROJECT_ONLY=true

  # ===== Misc =====
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=off
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true

  (( ! $+functions[p10k] )) || p10k reload
}

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
