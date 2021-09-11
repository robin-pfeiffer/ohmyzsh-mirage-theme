#!/usr/bin/env zsh

# Mirage for Oh my zsh
# by Robin Pfeiffer

build_segment() {
    local segment

    [[ -n $1 ]] && segment="$1 " || segment=""

    echo -n $segment
}

___mirage_prompt_start() {
    # Reset text options
    echo -n "%{%k%f%b%}"
}

___mirage_prompt_end() {
    # Reset text options
    echo -n "%{%k%f%b%}"
}


# Venv subsegments

___mirage_prompt_venv_python() {
    # local venv_path="$VIRTUAL_ENV"
    # if [[ -n $virtualenv_path && -ne $THEME_SHOW_VENV ]]; then
        # build_segment `basename $virtualenv_path`
    # fi
}

# Segments

___mirage_prompt_venv() {
    local -a subsegments
    for venv_seg in ${=___MIRAGE_VENV}; do
        subsegments+=$(___mirage_prompt_venv_$venv_seg)
    done

    [[ -z $subsegments ]] && return

    build_segment "%B%F{white}venv:(%f%b$subsegments%B%F{white})%f%b"
}

___mirage_prompt_scm() {
    [[ "$THEME_SHOW_SCM" ]] &&
        build_segment "$(git_prompt_info)"
}

___mirage_prompt_dir() {
    build_segment "in %B%F{cyan}%1~%f%b"
}

___mirage_prompt_host_info() {
    build_segment "on %B%F{magenta}%m%f%b"
}

___mirage_prompt_user_info() {
    color="%B%F{blue}"

    [[ "$THEME_SHOW_USER_INFO" ]] &&
        sudo -vn 1> /dev/null 2>&1 &&
        color="%B%F{red}"

    build_segment "$color%n%f%b"
}

___mirage_prompt_exitcode() {
    color="%B%F{green}"
    [[ "$THEME_SHOW_EXITCODE" ]] &&
        [[ "$exitcode" -ne 0 ]] &&
        color="%B%F{red}"
    
    build_segment "$color❯%f%b"
}

export ZSH_THEME_GIT_PROMPT_PREFIX="%B%F{blue}git:(%f%b"
export ZSH_THEME_GIT_PROMPT_SUFFIX="%B%F{blue})%f%b"
export ZSH_THEME_GIT_PROMPT_DIRTY=" %B%F{yellow}±%f%b"
export ZSH_THEME_GIT_PROMPT_CLEAN=" %B%F{green}✓%f%b"

export ZSH_THEME_SVN_PROMPT_PREFIX="%B%F{blue}svn:(%f%b"
export ZSH_THEME_SVN_PROMPT_SUFFIX="%B%F{blue})%f%b"
export ZSH_THEME_SVN_PROMPT_DIRTY=" %B%F{yellow}±%f%b"
export ZSH_THEME_SVN_PROMPT_CLEAN=" %B%F{green}✓%f%b"

THEME_SHOW_SCM=${THEME_SHOW_SCM:-true}
THEME_SHOW_USER_INFO=${THEME_SHOW_USER_INFO:-true}
THEME_SHOW_EXITCODE=${THEME_SHOW_EXITCODE:-true}
THEME_SHOW_VENV=${THEME_SHOW_VENV:-true}

# Define order of venv to show
___MIRAGE_VENV=${___MIRAGE_VENV:-"python"}

# Define order of main segments to show
___MIRAGE=${___MIRAGE:-"exitcode user_info host_info dir scm venv"}

___mirage() {
    ___mirage_prompt_start
    
    for seg in ${=___MIRAGE}; do
        ___mirage_prompt_$seg  
    done

    ___mirage_prompt_end
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

