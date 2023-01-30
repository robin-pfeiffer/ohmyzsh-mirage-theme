#!/usr/bin/env zsh

# Mirage for Oh my zsh
# by Robin Pfeiffer

build_segment() {
    local segment

    [[ -n $1 ]] && segment="$1 " || segment=""

    echo -n $segment
}

___mirage_prompt_reset() {
    # Reset text options
    echo -n "%{%k%f%}"
}

# Segments

___mirage_prompt_venv() {
    ("$THEME_SHOW_VENV") &&
        [[ -n $VIRTUAL_ENV ]] &&
        build_segment "%F{white}venv:(%f${VIRTUAL_ENV:t}%F{white})%f"
}

___mirage_prompt_scm() {
    ("$THEME_SHOW_SCM") &&
        build_segment "$(git_prompt_info)"
}

___mirage_prompt_dir() {
    build_segment "in %F{cyan}%1~%f"
}

___mirage_prompt_host_info() {
    build_segment "at %F{magenta}%m%f"
}

___mirage_prompt_user_info() {
    color="%F{blue}"

    # Shows if sudo has a timestamp file (sudo has been used within 
    # this session and is still valid)
    # activate: sudo su
    # reset: sudo -k
    ("$THEME_SHOW_SUDO") &&
        sudo -vn 1> /dev/null 2>&1 &&
        color="%F{red}"

    build_segment "$color%n%f"
}

___mirage_prompt_exitcode() {
    color="%F{green}"
    ("$THEME_SHOW_EXITCODE") &&
        [[ "$exitcode" -ne 0 ]] &&
        color="%F{red}"
    
    build_segment "$color❯%f"
}

# Prevent prompt mangling from venv/bin/activate
export VIRTUAL_ENV_DISABLE_PROMPT=true

export ZSH_THEME_GIT_PROMPT_PREFIX="%F{blue}git:(%f"
export ZSH_THEME_GIT_PROMPT_SUFFIX="%F{blue})%f"
export ZSH_THEME_GIT_PROMPT_DIRTY=" %F{yellow}±%f"
export ZSH_THEME_GIT_PROMPT_CLEAN=" %F{green}✓%f"

export ZSH_THEME_SVN_PROMPT_PREFIX="%F{blue}svn:(%f"
export ZSH_THEME_SVN_PROMPT_SUFFIX="%F{blue})%f"
export ZSH_THEME_SVN_PROMPT_DIRTY=" %F{yellow}±%f"
export ZSH_THEME_SVN_PROMPT_CLEAN=" %F{green}✓%f"

THEME_SHOW_SCM=${THEME_SHOW_SCM:-true}
THEME_SHOW_SUDO=${THEME_SHOW_SUDO:-true}
THEME_SHOW_EXITCODE=${THEME_SHOW_EXITCODE:-true}
THEME_SHOW_VENV=${THEME_SHOW_VENV:-true}

# Define order of main segments to show
___MIRAGE=${___MIRAGE:-"exitcode user_info host_info dir scm venv"}

___mirage() {
    ___mirage_prompt_reset
    
    for seg in ${=___MIRAGE}; do
        ___mirage_prompt_$seg  
    done

    ___mirage_prompt_reset
}

__mirage_ps1() {
    PS1="$(___mirage)"
    echo -n "$PS1"
}

_mirage_prompt() {
    exitcode="$?"
    __mirage_ps1
}

PROMPT='$(_mirage_prompt)'

